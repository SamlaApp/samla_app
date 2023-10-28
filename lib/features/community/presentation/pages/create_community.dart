import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:samla_app/config/themes/common_styles.dart';
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

  final _nameValidator = RequiredValidator(errorText: 'Name is required');
  final _descriptionValidator =
      RequiredValidator(errorText: 'Description is required');
  final _handleValidator = RequiredValidator(errorText: 'Handle is required');

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  final cubit = CreateCommunityCubit(sl<CommunityRepository>());

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // All fields are valid, you can create the Community object and proceed
      final community = Community(
          name: _nameController.text,
          description: _descriptionController.text,
          isPublic: _isPublic,
          handle: _handleController.text,
          isMemeber: true, // You can set this value as needed
          avatar: _image,
          imageURL: '',
          numOfMemebers: 0 // Set the image URL based on the uploaded image
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
                content: Text('Community created successfully'),
              ),
            );
          });
          // refresh the list of communities
          sl<CommunityCubit>().getMyCommunities();
          // close the create community page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CommunityPage(community: state.community),
            ),
          );
        }
        if (state is CreateLoadingState) {
          // show loading indicator
          return Center(
            child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Create Community'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: _nameValidator,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                      validator: _descriptionValidator,
                    ),
                    TextFormField(
                      controller: _handleController,
                      decoration: InputDecoration(labelText: 'Handle'),
                      validator: _handleValidator,
                    ),
                    SwitchListTile(
                      title: Text('Public Community'),
                      value: _isPublic,
                      onChanged: (newValue) {
                        setState(() {
                          _isPublic = newValue;
                        });
                      },
                    ),
                    ListTile(
                      title: Text('Community Avatar'),
                      trailing: _image == null
                          ? Text('No Image Selected')
                          : Image.file(_image!),
                      onTap: _pickImage,
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Create Community'),
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
