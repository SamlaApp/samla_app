import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/new_style.dart';
import 'package:samla_app/core/widgets/CustomTextFormField.dart';
import 'package:samla_app/core/widgets/image_helper.dart';
import 'package:samla_app/core/widgets/image_viewer.dart';
import 'package:samla_app/core/widgets/loading.dart';
import 'package:samla_app/features/auth/auth_injection_container.dart';
import 'package:samla_app/features/community/domain/entities/Community.dart';
import 'package:samla_app/features/community/domain/repositories/community_repository.dart';
import 'package:samla_app/features/community/presentation/cubits/CreateCommunity/create_community_cubit.dart';
import 'package:samla_app/features/community/presentation/cubits/MyCommunitiesCubit/community_cubit.dart';
import 'package:samla_app/features/community/presentation/pages/community_page.dart';

class CreateCommunityPage extends StatefulWidget {
  @override
  _CreateCommunityPageState createState() => _CreateCommunityPageState();
}

class _CreateCommunityPageState extends State<CreateCommunityPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _handleController = TextEditingController();
  File? _image;
  bool _isPublic = false;

  String? _nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  String? _descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length > 255) {
      return 'Description should not exceed 255 characters';
    }

    return null;
  }

  String? _handleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Handle is required';
    }
    if (value.length < 3) {
      return 'Handle must be at least 3 characters long';
    }
    //no spaces except at the beginning or end
    if (value.trim().contains(' ')) {
      return 'Handle should not contain spaces';
    }
    //no special characters except _
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Handle should not contain special characters except _';
    }

    return null;
  }

  Future<void> _pickImage() async {
    final ImageHelper _imageHelper = ImageHelper();
    final imagePath = await _imageHelper.pickImage(context, (image) {
      setState(() {
        _image = image;
      });
    });
  }

  final cubit = CreateCommunityCubit(sl<CommunityRepository>());

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid, you can create the Community object and proceed
      final community = Community(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          isPublic: _isPublic,
          handle: _handleController.text.trim()[0] == '@'
              ? _handleController.text.trim()
              : '@${_handleController.text.trim()}',
          isMemeber: true,
          // You can set this value as needed
          avatar: _image,
          imageURL: '',
          numOfMemebers: 0,
          ownerID: -1 // it is not needed here, backend will set it
          );

      // You can use this community object for further processing
      cubit.createCommunity(community);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCommunityCubit, CreateCommunityState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is CreateErrorState) {
          // show snackbar
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          });
        }

        if (state is CreatedSuccessfullyState) {
          // show snackbar
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: themeBlue.withOpacity(0.65),
                content: const Text('Community created successfully'),
              ),
            );

            sl<CommunityCubit>().getMyCommunities();
            // close the create community page

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CommunityPage(community: state.community),
              ),
            );
          });
          // refresh the list of communities
        }
        if (state is CreateLoadingState) {
          // show loading indicator
          return Center(
            child: LoadingWidget(),
          );
        } else {
          return Scaffold(
            backgroundColor: themeDarkBlue,
            appBar: AppBar(
              shadowColor: primaryColor,
              backgroundColor: themeDarkBlue,
              toolbarHeight: 150.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    'images/Logo/2x/Icon_1@2x.png',
                    height: 60, // Adjust the size as needed
                  ),
                  const SizedBox(height: 10),
                  const Text('New Community',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ImageViewer.file(
                        imageFile: _image,
                        editableCallback: (newImage) {
                          setState(() {
                            _image = newImage;
                          });
                        },
                        title: 'Community Avatar',
                      ),
                      const SizedBox(height: 60),
                      CustomTextFormField(
                        controller: _nameController,
                        // decoration: InputDecoration(labelText: 'Name'),
                        validator: _nameValidator,
                        label: 'Name',
                        iconData: Icons.person,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _descriptionController,
                        label: 'Description',
                        validator: _descriptionValidator,
                        iconData: Icons.description,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFormField(
                        controller: _handleController,
                        validator: _handleValidator,
                        label: 'Handle',
                        iconData: Icons.alternate_email,
                      ),
                      SwitchListTile(
                        activeTrackColor: themeBlue.withOpacity(0.65),
                        thumbColor: MaterialStateProperty.all<Color>(themeBlue),
                        inactiveTrackColor: inputFieldColor,
                        title: Text(
                          'Public Community',
                          style:
                              TextStyle(color: themeDarkBlue.withOpacity(0.95)),
                        ),
                        value: _isPublic,
                        onChanged: (newValue) {
                          setState(() {
                            _isPublic = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: themeDarkBlue,
                        ),
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _submitForm,
                          child: const Text('Create Community',
                              style: TextStyle(
                                  color: white,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 300),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
