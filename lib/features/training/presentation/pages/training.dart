import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/presentation/pages/startTrainingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../config/themes/new_style.dart';
import '../../domain/entities/ExerciseLibrary.dart';
import '../../domain/entities/Template.dart';
import '../cubit/viewDayExercise/viewDayExercise_cubit.dart';
import '../widgets/ExercisesbyDay.dart';
import 'Tamplates_page.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final String baseURL =
      'https://samla.mohsowa.com/api/training/image/'; // api url for images
  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1); // capitalize first letter of string

  late TemplateCubit templateCubit; // Declare the cubit
  late ViewDayExerciseCubit viewDayExerciseCubit; // Declare the cubit
  Map<int, bool> dayCompletionStatus = {};
  final _controller = PageController();
  Map<String, List<ExerciseLibrary>> weeklyExercises = {};
  ValueNotifier<int?> activeTemplateId = ValueNotifier(null);
  late String Tamplatename;

  @override
  void initState() {
    super.initState();

    di.trainingInit(); // Initialize the training module
    templateCubit = di.sl.get<TemplateCubit>(); // Get the cubit instance
    viewDayExerciseCubit =
        di.sl.get<ViewDayExerciseCubit>(); // Get the cubit instance

    templateCubit.activeTemplate(); // Get the active template

    activeTemplateId.addListener(() {
      if (activeTemplateId.value != null) {
        _fetchWeeklyExercises();
      }
    });
  }

  int findFirstIncompleteDayIndex() {
    for (int i = 0; i < dayCompletionStatus.length; i++) {
      if (!dayCompletionStatus[i]! &&
          weeklyExercises[_getDayNameFromIndex(i)]!.isNotEmpty) {
        return i;
      }
    }
    return 0; // Default to the first day if all are complete or empty
  }

  Future<void> _fetchWeeklyExercises() async {
    const days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ];
    int templateId = activeTemplateId.value ?? 0;

    for (var day in days) {
      var result = await viewDayExerciseCubit.repository
          .getExercisesDay(day: day, templateID: templateId);
      setState(() {
        weeklyExercises[day] = result.getOrElse(() => []);
      });
    }

    for (int i = 0; i < 7; i++) {
      bool? status = await _getCompletionStatus(i) ?? false;
      dayCompletionStatus[i] = status;
    }

    int firstIncompleteDayIndex = findFirstIncompleteDayIndex();
    if (_controller.hasClients) {
      // Use animateToPage for a smoother transition
      _controller.animateToPage(
        firstIncompleteDayIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<bool?> _getCompletionStatus(int dayIndex) async {
    final prefs = await SharedPreferences.getInstance();
    int? templateId = activeTemplateId.value;
    String key = 'completed_status_${templateId}_$dayIndex';
    return prefs.getBool(key);
  }

  String _getDayNameFromTemplate(Template template, int index) {
    switch (index) {
      case 0:
        return template.sunday ?? "Sunday";
      case 1:
        return template.monday ?? "Monday";
      case 2:
        return template.tuesday ?? "Tuesday";
      case 3:
        return template.wednesday ?? "Wednesday";
      case 4:
        return template.thursday ?? "Thursday";
      case 5:
        return template.friday ?? "Friday";
      case 6:
        return template.saturday ?? "Saturday";
      default:
        return "Unknown Day";
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
      case 0:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      default:
        return "Unknown Day";
    }
  }

  void _navigateToStartTrainingNew(
      String dayName, int dayIndex, List<ExerciseLibrary> exercises) async {
    // If there are no exercises for the day, mark it as complete
    if (exercises.isEmpty) {
      _markDayAsComplete(dayIndex);
      return;
    }

    // Navigate to StartTrainingNew and wait for completion
    bool? isCompleted = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StartTraining(
          dayName: dayName,
          dayIndex: dayIndex,
          exercises: exercises,
          templateName: Tamplatename,
        ),
      ),
    );

    // Update the completion status if training is completed
    if (isCompleted == true) {
      _markDayAsComplete(dayIndex);
    }
  }

  Future<void> _saveCompletionStatus(int dayIndex, bool status) async {
    final prefs = await SharedPreferences.getInstance();
    int? templateId = activeTemplateId.value;
    String key = 'completed_status_${templateId}_$dayIndex';
    await prefs.setBool(key, status);
  }

  void _markDayAsComplete(int dayIndex) async {
    setState(() => dayCompletionStatus[dayIndex] = true);
    await _saveCompletionStatus(dayIndex, true);

    // Check if all days with exercises are completed
    bool allCompleted = dayCompletionStatus.entries.every((entry) {
      int day = entry.key;
      bool status = entry.value;
      // Check if the day has exercises and if it's completed
      return weeklyExercises[_getDayNameFromIndex(day)]?.isNotEmpty != true ||
          status;
    });

    if (allCompleted) {
      // Reset logic remains the same
      Map<int, bool> newStatus = {
        for (var item in List.generate(7, (index) => index)) item: false
      };

      for (int i = 0; i < 7; i++) {
        await _saveCompletionStatus(i, false);
      }

      setState(() => dayCompletionStatus = newStatus);
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
              controller: _controller,
              count: 7, // the number of dots should match the number of pages
              effect: const JumpingDotEffect(
                dotHeight: 6,
                dotWidth: 6,
                jumpScale: 3,
                activeDotColor: themeBlue,
                dotColor: Colors.grey,
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
          return const Center(
              child: CircularProgressIndicator(
            color: themeBlue,
            backgroundColor: themePink,
          ));
        } else if (state is ActiveTemplateLoaded) {
          return PageView.builder(
            controller: _controller,
            itemCount: 7, // One for each day of the week
            itemBuilder: (BuildContext context, int index) {
              String dayNameFromTemplate =
                  _getDayNameFromTemplate(state.template, index);
              return Container(
                width: MediaQuery.of(context).size.width - 40,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [themeDarkBlue, themeBlue],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
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
                        child: Text(
                          capitalize(dayNameFromTemplate),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),

                      // Exercises
                      const SizedBox(height: 16),
                      buildExercisesForDay(context, index, weeklyExercises),

                      // buildGradientBorderButton(context),
                      if (weeklyExercises[_getDayNameFromIndex(index)] !=
                              null &&
                          weeklyExercises[_getDayNameFromIndex(index)]!
                              .isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Center(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton.icon(
                                label: Text(
                                  dayCompletionStatus[index] == true
                                      ? 'Completed'
                                      : 'Start Now',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                onPressed: () => _navigateToStartTrainingNew(
                                    dayNameFromTemplate,
                                    index,
                                    weeklyExercises[
                                            _getDayNameFromIndex(index)] ??
                                        []),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  side: const BorderSide(
                                      width: 2.0, color: Colors.white),
                                ),
                                icon: Icon(
                                  dayCompletionStatus[index] == true
                                      ? Icons.check
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
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
        return const Center(
            child: CircularProgressIndicator(
          color: themeBlue,
          backgroundColor: themePink,
        ));
      },
    );
  }

  BlocBuilder<TemplateCubit, TemplateState> _activeTemplate() {
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: templateCubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                color: themeBlue,
                backgroundColor: themePink,
              ),
            ),
          );
        } else if (state is ActiveTemplateLoaded) {
          Tamplatename = state.template.name;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.template.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeDarkBlue,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  IconButton(
                    onPressed: _navigateToTemplatesPage,
                    icon: const Icon(Icons.dashboard_outlined,
                        color: themeDarkBlue, size: 30),
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
