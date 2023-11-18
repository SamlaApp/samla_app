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
  final cubit = TemplateCubit(di.sl.get());

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
      final template = Template(
        name: nameController.text,
        is_active: false,
      );
      cubit.createTemplate(template);
      Navigator.of(context).pop();
    }
  }

  // void showExercisesDialog(String dayName, String exercises) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         insetPadding: EdgeInsets.all(13),
  //         child: Container(
  //           width: MediaQuery.of(context).size.width * 0.9,
  //           padding: EdgeInsets.all(20.0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Text(dayName,
  //                   style:
  //                       TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
  //               SizedBox(height: 20.0),
  //               SingleChildScrollView(
  //                 child: ListBody(
  //                   children: exercises.split(', ').map((exercise) {
  //                     return Card(
  //                       clipBehavior: Clip.antiAlias,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                       child: ListTile(
  //                         leading: Padding(
  //                           padding: const EdgeInsets.all(3.0),
  //                           child: Image.network(
  //                             'https://source.unsplash.com/featured/?gym',
  //                             // Replace with your exercise image link
  //                             width: 60,
  //                             height: 60,
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                         title: Text(
  //                           exercise, // The name of the exercise
  //                           style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         trailing: IconButton(
  //                           icon: Icon(Icons.info_outline),
  //                           onPressed: () {
  //                             // The functionality for showing exercise details goes here
  //                             _showExerciseDetails(context,
  //                                 exercise); // Make sure to define this method to show details
  //                           },
  //                         ),
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //               SizedBox(height: 20.0),
  //               TextButton(
  //                 child: Text('Close'),
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _showExerciseDetails(BuildContext context, String exercise) {
  //   // Implement your exercise details presentation logic here
  // }

  ////////////////////////////  ////////////////////////////  ////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Workout Templates",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              // Implement the functionality for adding a new template
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
            theme_darkblue,
            theme_red,
          ],
          secondaryColors: [
            theme_pink,
            theme_red,
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //
            //buildStartEmptyWorkoutButton(),
            // SizedBox(height: 16),
            buildTemplatesHeader(context),
            // SizedBox(height: 16),
            //
            // Expanded(child: buildTemplateList(),),
            Expanded(child: buildBlocBuilder()),
          ],
        ),
      ),
    );
  }

  ////////////////////////////  ////////////////////////////  ////////////////////////////  ////////////////////////////

  // Widget buildStartEmptyWorkoutButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       // Implement the functionality for starting an empty workout
  //     },
  //     child: Container(
  //       padding: EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: theme_green, width: 2),
  //         // Define your theme_green color in your theme
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             'Start Empty Workout',
  //             style: TextStyle(
  //               color: theme_green,
  //               // Define your theme_green color in your theme
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //

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
                color: theme_darkblue,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: theme_darkblue),
            onPressed: () {
              refresh();
            },
          ),
        ],
      ),
    );
  }

  //
  // Widget buildTemplateList() {
  //   return ListView.builder(
  //     itemCount: templates.length,
  //     itemBuilder: (context, index) {
  //       final template = templates[index];
  //       return buildTemplateCard(template);
  //     },
  //   );
  // }
  //
  // Widget buildTemplateCard(Map<String, dynamic> template) {
  //   String templateName = template['templateName'];
  //   bool isTemplateAdded = addedTemplates[templateName] ?? false;
  //
  //   return Card(
  //     child: Stack(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 template['templateName'] as String,
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               SizedBox(height: 16),
  //               Container(
  //                 height: 80,
  //                 child: ListView(
  //                   scrollDirection: Axis.horizontal,
  //                   children: (template['days'] as List).map<Widget>((day) {
  //                     return InkWell(
  //                       onTap: () => showExercisesDialog(
  //                         day['dayName'] as String,
  //                         day['exercises'] as String,
  //                       ),
  //                       child: buildDayCard(day),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //           top: 8,
  //           right: 8,
  //           child: IconButton(
  //             onPressed: () {
  //               setState(() {
  //                 addedTemplates[templateName] = !isTemplateAdded;
  //               });
  //             },
  //             icon: Icon(
  //               isTemplateAdded ? Icons.toggle_on : Icons.toggle_off,
  //               size: 40,
  //               color: isTemplateAdded ? theme_green : Colors.grey,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget buildDayCard(Map<String, dynamic> day) {
  //   return Card(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             day['dayName'] as String,
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 8),
  //           Text(day['exercises'] as String),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Create new Template
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
                   Icon(Icons.file_present_rounded, color: theme_darkblue, size: 25),
                   const SizedBox(width: 10),
                   Text('New Template',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Cairo',color: theme_darkblue),
                      overflow: TextOverflow.ellipsis,),
                 ],
               ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Template Name',
                  focusColor: theme_green,
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
                      foregroundColor: theme_red, backgroundColor: Colors.white,
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
                      foregroundColor: Colors.white, backgroundColor: theme_darkblue,
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
              color: theme_green,
              backgroundColor: theme_pink,
            ),
          );
        } else if (state is TemplateLoaded) {
          return ListView.builder(
            itemCount: state.templates.length,
            itemBuilder: (context, index) {
              final template = state.templates[index];
              return _buildTemplateCard(template);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  // Display Template Card
  Widget _buildTemplateCard(Template template) {
    bool isActive = template.is_active;
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
            theme_darkblue,
            theme_pink,
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
                if(isActive)
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
                    builder: (context) => TemplatePage(template: template),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: theme_darkblue,
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
