import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';
import 'package:samla_app/features/training/presentation/cubit/Exercises/exercise_cubit.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/presentation/widgets/bodyPartsDropDown.dart';
import 'package:samla_app/features/training/presentation/widgets/ExersciseItem.dart';
import '../../../../config/themes/common_styles.dart';
import '../../../nutrition/presentation/widgets/MaelAdapt/DayDropdown.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

// class NewTemplatePage extends StatefulWidget {
//   NewTemplatePage({Key? key}) : super(key: key);
//
//   @override
//   _NewTemplatePageState createState() => _NewTemplatePageState();
// }
//
// class _NewTemplatePageState extends State<NewTemplatePage> {
//   final _controller = PageController();
//   double _currentPage = 0;
//   final _templateNameController = TextEditingController();
//
//   bool _isLoadingExercises = true;
//
//   late final ExerciseRepository _exerciseRepository;
//   List<ExerciseModel> _allExercises= []; // To store all available exercises
//
//   // Initialize _dayModels as an empty list right away
//   List<DayModel> _dayModels = [];
//
//   late final TempTemplateRepository _templateRepository;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize the MockDataSource and TemplateRepository
//     MockDataSource mockDataSource = MockDataSource();
//     _templateRepository = TempTemplateRepository(mockDataSource);
//
//     // Initialize the ExerciseRepository
//     _exerciseRepository = ExerciseRepository(mockDataSource);
//
//     // Initialize _dayModels with one DayModel item immediately
//     _dayModels = [DayModel(dayId: 'Day1', dayName: "Day 1", exercises: [])];
//
//     // Fetch all exercises asynchronously
//     _initializeData();
//
//     _controller.addListener(() {
//       setState(() {
//         _currentPage = _controller.page ?? 0;
//       });
//     });
//   }
//
//   void _initializeData() async {
//     try {
//       var exercises = await _exerciseRepository.getExercises();
//       setState(() {
//         _allExercises = exercises;
//         _isLoadingExercises = false;
//       });
//       print("Exercises fetched, isLoadingExercises set to false");
//     }
//     catch (error) {
//       print('Error fetching exercises: $error');
//       // You might want to handle the error state as well
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: _buildBody(),
//     );
//   }
//
//
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       title: Text('New Template', style: TextStyle(color: Colors.black)),
//       iconTheme: IconThemeData(color: Colors.black),
//       actions: [
//
//         GestureDetector(
//           onTap: () => _saveTemplate(),
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             //alignment: Alignment.center,
//             child: Text(
//               'Save',
//               style: TextStyle(
//                 color: Colors.blue,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Column _buildBody() {
//     return Column(
//       children: [
//         _buildTemplateNameInput(),
//         _buildPageView(),
//         _buildBottomRow(),
//
//       ],
//     );
//   }
//
//   Padding _buildTemplateNameInput() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextField(
//         controller: _templateNameController,
//         decoration: InputDecoration(
//           hintText: 'Enter Template Name',
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: theme_darkblue),
//           ),
//         ),
//         style: GoogleFonts.roboto(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
//
//   Expanded _buildPageView() {
//     return Expanded(
//       child: PageView.builder(
//         controller: _controller,
//         itemCount: _dayModels.length,
//         itemBuilder: (context, index) {
//           return DayCard(
//             day: _dayModels[index].dayName,
//             onAddExercise: () => _showExerciseSelectionDialog(context, index),
//             exercises: _dayModels[index].exercises,
//           );
//         },
//       ),
//     );
//   }
//
//   Padding _buildBottomRow() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 40.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _buildPageIndicator(),
//           SizedBox(width: 12),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(primary: theme_green),
//             onPressed: () => _addNewDay(),
//             child: Text("Add Day"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Row _buildPageIndicator() {
//     return Row(
//       children: List.generate(
//         _dayModels.length,
//             (index) => Container(
//           width: 17,
//           height: 33,
//           margin: EdgeInsets.symmetric(horizontal: 4.0),
//           decoration: BoxDecoration(
//             color: _currentPage.round() == index ? theme_green : Colors.grey,
//             borderRadius: BorderRadius.circular(4.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showExerciseSelectionDialog(BuildContext context, int dayIndex) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return ExerciseSelectionDialog(
//           day: _dayModels[dayIndex].dayName,
//           allExercises: _allExercises,
//           isLoading: _isLoadingExercises, // Pass the loading flag
//           onSelectedExercises: (List<ExerciseModel> selectedExercises) {
//             setState(() {
//               _dayModels[dayIndex].exercises.clear();
//               _dayModels[dayIndex].exercises.addAll(selectedExercises);
//             });
//           },
//         );
//       },
//     );
//   }
//
//
//
//
//
//
//   void _addNewDay() {
//     setState(() {
//       _dayModels.add(DayModel(dayId: 'ID', dayName: "Day ${_dayModels.length + 1}", exercises: []));
//     });
//   }
//
//   void _saveTemplate() {
//     // Implement logic to save the template
//     TempTemplateModel newTemplate = TempTemplateModel(
//       templateId: 'UniqueID',
//       templateName: _templateNameController.text,
//       creator: 'UserID',  // Adjust based on your user management
//       isCustomizable: true,
//       days: _dayModels,
//     );
//     // Use _templateRepository to save the new template
//   }
// }

// ########### New UI style start from here ####################

class TemplatePage extends StatefulWidget {
  late Template template;

  TemplatePage({super.key, required this.template});

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  final templateCubit = di.sl.get<TemplateCubit>();
  final exercisesCubit = di.sl.get<ExerciseCubit>();

  String _selectedBodyPart = 'Back';

  @override
  void initState() {
    super.initState();
    exercisesCubit.getBodyPartExerciseLibrary(part: _selectedBodyPart);
  }

  void _deleteTemplate() {
    templateCubit.deleteTemplate(widget.template.id!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150.0,
          title: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.template.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        print('Should show a dialog to update the template');
                      },
                      child:
                          const Text('Update', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme_pink, theme_darkblue],
                tileMode: TileMode.clamp,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: primary_color,
            unselectedLabelColor: Colors.white,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w300,
            ),
            tabs: const [
              Tab(text: 'Your Current Plan'),
              Tab(text: 'Find More Exercises'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.white, size: 30),
              onPressed: () {
                _deleteTemplate();
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _currentPlanContent(),
            _findExercisesContent(),
          ],
        ),
      ),
    );
  }

// First tab
  Widget _currentPlanContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Text area box
                Expanded(
                  flex: 1,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Your daily plan name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16), // Spacing between the two widgets

                Expanded(
                  flex: 1,
                  child: DayDropdown(
                    initialValue: null,
                    onChanged: (String newValue) {
                      // Handle changes here
                    },
                    color: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Second tab
  Widget _findExercisesContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Body Part',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BodyPartDropdown(
                    initialValue: null,
                    onChanged: (String newValue) {
                      _selectedBodyPart = newValue;
                      exercisesCubit.getBodyPartExerciseLibrary(part: newValue);
                    },
                    color: Colors.black,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildBodyPartExercises(),
          ],
        ),
      ),
    );
  }

  BlocBuilder<ExerciseCubit, ExerciseState> _buildBodyPartExercises() {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      bloc: exercisesCubit,
      builder: (context, state) {
        if (state is ExerciseLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ExerciseLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var exercise in state.exercises)
                  ExerciseItem(
                    id: exercise.id,
                    name: exercise.name,
                    bodyPart: exercise.bodyPart,
                    equipment: exercise.equipment,
                    gifUrl: exercise.gifUrl,
                    target: exercise.target,
                    instructions: exercise.instructions,
                    secondaryMuscles: exercise.secondaryMuscles,
                    gradient: LinearGradient(
                      colors: [theme_pink, theme_darkblue],
                      tileMode: TileMode.clamp,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    onRemove: () {
                      print('Remove exercise');
                    },
                  ),
              ],
            ),
          );
        } else if (state is ExerciseErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
