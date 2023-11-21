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
import '../widgets/MainPageExerciseItem.dart';
import '../widgets/mainPageStartNowbutton.dart';
import 'Tamplates_page.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:samla_app/features/training/training_di.dart' as di;

class TrainingPage extends StatefulWidget {
  TrainingPage({Key? key}) : super(key: key);

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final _controller = PageController();
  double _currentPage = 0;
  final String baseURL = 'https://samla.mohsowa.com/api/training/image/'; // api url for images
  late TemplateCubit cubit;
  late ViewDayExerciseCubit cubit2;
  Map<String, List<ExerciseLibrary>> weeklyExercises = {};

  ValueNotifier<int?> activeTemplateId = ValueNotifier(null);

  @override
  @override
  void initState() {
    super.initState();
    di.trainingInit(); // Initialize the training module
    cubit = di.sl<TemplateCubit>(); // Get the cubit instance
    cubit2 = di.sl<ViewDayExerciseCubit>(); // Get the cubit instance

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
      cubit2.repository.getExercisesDay(day: day, templateID: templateId).then((result) {
        setState(() {
          weeklyExercises[day] = result.getOrElse(() => []);
        });
      });
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
      bloc: cubit,
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
      bloc: cubit,
      builder: (context, state) {
        if (state is TemplateLoadingState) {
          return Center(child: CircularProgressIndicator());
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
                decoration: primary_decoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(dayNameFromTemplate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    buildExercisesForDay(context, index, weeklyExercises),
                    buildGradientBorderButton(context),
                  ],
                ),
              );
            },
          );
        } else if (state is TemplateEmptyState) {
          return Center(child: Text('No active template found'));
        } else if (state is TemplateErrorState) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
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





  BlocBuilder<TemplateCubit, TemplateState> _activeTemplate() {
    cubit.activeTemplate();
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: cubit,
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme_red, theme_darkblue],
                  tileMode: TileMode.clamp,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                backgroundBlendMode: BlendMode.darken,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    state.template.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  IconButton(
                      onPressed:_navigateToTemplatesPage,
                      icon: const Icon(Icons.edit, color: Colors.white)
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




  void _navigateToTemplatesPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TemplatesPage()),
    );

    // This line will be executed after you pop back from TemplatesPage
    _fetchDataOrRefreshState(); // Call your method to refresh or fetch data
  }
  void _fetchDataOrRefreshState() {
    cubit.activeTemplate(); // To refresh the active template
    if (activeTemplateId.value != null) {
      _fetchWeeklyExercises(); // To refresh weekly exercises
    }
  }

}






