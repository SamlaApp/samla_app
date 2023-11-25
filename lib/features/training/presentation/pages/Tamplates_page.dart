import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/config/themes/common_styles.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/presentation/pages/tamplate_page.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  _TemplatesPageState createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  final cubit = di.sl.get<TemplateCubit>();

  Map<String, bool> addedTemplates = {};

  @override
  void initState() {
    super.initState();
    cubit.getAllTemplates();
  }

  void refresh() {
    setState(() {
      cubit.getAllTemplates();
    });
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      Template template = Template(
        name: nameController.text,
        is_active: false,
      );

      nameController.clear();

      cubit.createTemplate(template);
      Navigator.of(context).pop();
      cubit.getAllTemplates();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout Templates",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return buildNewTemplateDialog();
                },
              );
            },
          ),
        ],
        flexibleSpace: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomRight,
          secondaryEnd: Alignment.topLeft,
          primaryColors: [
            theme_orange,
            themePink,
          ],
          secondaryColors: [
            themePink,
            theme_red,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildTemplatesHeader(context),
            Expanded(child: buildBlocBuilder()),
          ],
        ),
      ),
    );
  }

  // Done
  Widget buildTemplatesHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Templates',
            style: TextStyle(
                color: themeDarkBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: themeDarkBlue),
            onPressed: () {
              refresh();
            },
          ),
        ],
      ),
    );
  }

  Widget buildNewTemplateDialog() {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.file_present_rounded,
                      color: themeDarkBlue, size: 25),
                  const SizedBox(width: 10),
                  Text(
                    'New Template',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: themeDarkBlue),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Template Name',
                  focusColor: themeBlue,
                ),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme_red,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      _submitForm();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Create'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: themeDarkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Display Templates
  BlocBuilder<TemplateCubit, TemplateState> buildBlocBuilder() {
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: themeBlue,
              backgroundColor: themePink,
            ),
          );
        }
        else if (state is TemplateDeletedState) {
          cubit.getAllTemplates();
          return Center(
            child: CircularProgressIndicator(
              color: themeBlue,
              backgroundColor: themePink,
            ),
          );
        }
        // TemplateCreatedState
        else if (state is TemplateCreatedState) {
          cubit.getAllTemplates();
          return Center(
            child: CircularProgressIndicator(
              color: themeBlue,
              backgroundColor: themePink,
            ),
          );
        }

        else if (state is TemplateLoaded) {
          return ListView.builder(
            itemCount: state.templates.length,
            itemBuilder: (context, index) {
              final template = state.templates[index];
              return _buildTemplateCard(template,state.templates.length); 
            },
          );
        } else {
          return Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.gpp_maybe_rounded, color: theme_orange, size: 50),
                const SizedBox(height: 10),
                Text('Something went wrong',
                    style: TextStyle(
                      color: themeDarkBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
                TextButton(
                  onPressed: () {
                    refresh();
                  },
                  child: Text('Try again',
                      style: TextStyle(
                        color: themeBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),

          );
        }
      },
    );
  }

  // Display Template Card
  Widget _buildTemplateCard(Template template, int length) {
    bool? isActive = template.is_active;
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            themeDarkBlue,
            themePink,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Row(
              children: [
                Text(
                  template.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                if (isActive == true)
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
              ],
            ),
            const Spacer(),
            // view
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TemplatePage(template: template, length: length),
                  ),
                ).then((_) {
                  // This block runs when you pop back to TemplatesPage
                  refresh(); // Refresh your TemplatesPage here
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: themeDarkBlue,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}
