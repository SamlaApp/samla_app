import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/presentation/pages/startTrainig.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/themes/common_styles.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../../domain/entities/Template.dart';
import '../cubit/viewDayExercise/viewDayExercise_cubit.dart';
import '../widgets/ExercisesbyDay.dart';
import '../widgets/mainPageStartNowbutton.dart';
import 'Tamplates_page.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {

  final String baseURL = 'https://samla.mohsowa.com/api/training/image/'; // api url for images
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1); // capitalize first letter of string


  late TemplateCubit templateCubit; // Declare the cubit
  late ViewDayExerciseCubit viewDayExerciseCubit; // Declare the cubit

  final _controller = PageController();
  Map<String, List<ExerciseLibrary>> weeklyExercises = {};

  ValueNotifier<int?> activeTemplateId = ValueNotifier(null);



  @override
  void initState() {
    super.initState();

    di.trainingInit(); // Initialize the training module
    templateCubit = di.sl.get<TemplateCubit>(); // Get the cubit instance
    viewDayExerciseCubit = di.sl.get<ViewDayExerciseCubit>(); // Get the cubit instance

    templateCubit.activeTemplate(); // Get the active template

    activeTemplateId.addListener(() {
      if (activeTemplateId.value != null) {
        _fetchWeeklyExercises();
      }
    });
  }


  void _fetchWeeklyExercises() {
    const days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    int templateId = activeTemplateId.value ?? 0; // Use the value from the notifier
    for (var day in days) {
      viewDayExerciseCubit.repository.getExercisesDay(day: day, templateID: templateId).then((result) {
        setState(() {
          weeklyExercises[day] = result.getOrElse(() => []);
        });
      });
    }
  }

  String _getDayNameFromTemplate(Template template, int index) {
    switch (index) {
      case 0: return template.sunday ?? "Sunday";
      case 1: return template.monday ?? "Monday";
      case 2: return template.tuesday ?? "Tuesday";
      case 3: return template.wednesday ?? "Wednesday";
      case 4: return template.thursday ?? "Thursday";
      case 5: return template.friday ?? "Friday";
      case 6: return template.saturday ?? "Saturday";
      default: return "Unknown Day";
    }
  }

  void _navigateToTemplatesPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TemplatesPage()),
    );

    // This line will be executed after you pop back from TemplatesPage
    _fetchDataOrRefreshState(); // Call your method to refresh or fetch data
  }
  void _fetchDataOrRefreshState() {
    templateCubit.activeTemplate(); // To refresh the active template
    if (activeTemplateId.value != null) {
      _fetchWeeklyExercises(); // To refresh weekly exercises
    }
  }
  String _getDayNameFromIndex(int index) {
    switch (index) {
      case 0: return "Sunday";
      case 1: return "Monday";
      case 2: return "Tuesday";
      case 3: return "Wednesday";
      case 4: return "Thursday";
      case 5: return "Friday";
      case 6: return "Saturday";
      default: return "Unknown Day";
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    activeTemplateId.dispose(); // Dispose the notifier
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<TemplateCubit, TemplateState>(
      bloc: templateCubit,
      listener: (context, state) {
        if (state is ActiveTemplateLoaded) {
          activeTemplateId.value = state.template.id;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            _activeTemplate(),
            Expanded(
              child: _buildTemplatePageView(),
            ),
            SmoothPageIndicator(
              controller: _controller, // make sure this is your PageController
              count: 7, // the number of dots should match the number of pages
              effect: const JumpingDotEffect(
                dotHeight: 6,
                dotWidth: 6,
                jumpScale: 3,
                activeDotColor: Color.fromRGBO(216, 46, 20, 1), // use your theme color here
                dotColor: Colors.grey, // use a color that suits your theme for inactive dots
              ),
            ),

          ],
        ),
      ),
    );
  }

  BlocBuilder<TemplateCubit, TemplateState> _buildTemplatePageView() {
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: templateCubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return Center(child: CircularProgressIndicator(
            color: theme_green,
            backgroundColor: theme_pink,
          ));
        } else if (state is ActiveTemplateLoaded) {
          return PageView.builder(
            controller: _controller,
            itemCount: 7, // One for each day of the week
            itemBuilder: (BuildContext context, int index) {
              String dayNameFromTemplate = _getDayNameFromTemplate(state.template, index);
              return Container(
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [theme_pink, theme_darkblue],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  backgroundBlendMode: BlendMode.darken,
                ),
                
                
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(capitalize(dayNameFromTemplate), style:  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo',),),
                      ),

                      // Exercises
                      const SizedBox(height: 16),
                      buildExercisesForDay(context, index, weeklyExercises),
                      

                      // buildGradientBorderButton(context),
                      if(weeklyExercises[_getDayNameFromIndex(index)] != null && weeklyExercises[_getDayNameFromIndex(index)]!.isNotEmpty)
                      Center(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton.icon(
                              label: const Text('Start Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Cairo',),),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StartTraining(dayIndex: index, templateId: state.template.id!),
                                  ),
                                );
                              },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: const BorderSide(width: 2.0, color: Colors.white),
                            ),
                              icon: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is TemplateEmptyState) {
          return const Center(child: Text('No active template found'));
        } else if (state is TemplateErrorState) {
          return Center(child: Text(state.message));
        }
        return Center(child: CircularProgressIndicator(
          color: theme_green,
          backgroundColor: theme_pink,
        ));
      },
    );
  }

  BlocBuilder<TemplateCubit, TemplateState> _activeTemplate() {
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: templateCubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: theme_green,
                backgroundColor: theme_pink,
              ),
            ),
          );
        } else if (state is ActiveTemplateLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.template.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme_darkblue,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  IconButton(
                      onPressed:_navigateToTemplatesPage,
                      icon: Icon(Icons.edit, color: theme_darkblue, size: 30),
                  ),
                ],
              ),
            ),
          );
        } else if (state is TemplateEmptyState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('No templates found'),
            ),
          );
        } else if (state is TemplateErrorState) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

}






