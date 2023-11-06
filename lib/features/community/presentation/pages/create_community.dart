import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:samla_app/config/themes/common_styles.dart';
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

  String? _nameValidator(String? value){
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  String? _descriptionValidator(String? value){
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length > 255) {
      return 'Description should not exceed 255 characters';
    }
    
    return null;

  }
  String? _handleValidator(String? value){
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
          isMemeber: true, // You can set this value as needed
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
                backgroundColor: theme_green.withOpacity(0.65),
                content: Text('Community created successfully'),
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
            appBar: AppBar(
              title: Text('New Community'),
              backgroundColor: theme_green,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
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
                    SizedBox(height: 60),
                    CustomTextField(
                      controller: _nameController,
                      // decoration: InputDecoration(labelText: 'Name'),
                      validator: _nameValidator,
                      label: 'Name',
                      iconData: Icons.person,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      validator: _descriptionValidator,
                      iconData: Icons.description,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _handleController,
                      validator: _handleValidator,
                      label: 'Handle',
                      iconData: Icons.alternate_email,
                    ),
                    SwitchListTile(
                      activeTrackColor: theme_green.withOpacity(0.65),
                      thumbColor: MaterialStateProperty.all<Color>(theme_green),
                      inactiveTrackColor: inputField_color,
                      title: Text('Public Community',style: TextStyle(color: theme_darkblue.withOpacity(0.95)),),
                      value: _isPublic,
                      onChanged: (newValue) {
                        setState(() {
                          _isPublic = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: theme_green,
                      ),

                      width: double.infinity,
                      child: TextButton(
                        onPressed: _submitForm,
                        child: const Text('Create Community',
                            style: TextStyle(color: Colors.white)),  
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
