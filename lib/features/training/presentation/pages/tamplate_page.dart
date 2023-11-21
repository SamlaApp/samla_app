import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';
import 'package:samla_app/features/training/presentation/cubit/Exercises/exercise_cubit.dart';
import 'package:samla_app/features/training/presentation/cubit/Templates/template_cubit.dart';
import 'package:samla_app/features/training/presentation/cubit/viewDayExercise/viewDayExercise_cubit.dart';
import 'package:samla_app/features/training/presentation/widgets/ViewDayExersciseItem.dart';
import 'package:samla_app/features/training/presentation/widgets/bodyPartsDropDown.dart';
import 'package:samla_app/features/training/presentation/widgets/ExersciseItem.dart';
import '../../../../config/themes/common_styles.dart';
import '../../../nutrition/presentation/widgets/MaelAdapt/DayDropdown.dart';
import 'package:samla_app/features/training/training_di.dart' as di;

class TemplatePage extends StatefulWidget {
  late Template template;

  TemplatePage({super.key, required this.template});

  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  final templateCubit = di.sl.get<TemplateCubit>();
  final exercisesCubit = di.sl.get<ExerciseCubit>();
  final viewDayExerciseCubit = di.sl.get<ViewDayExerciseCubit>();

  String _selectedBodyPart = 'Back';
  String _selectedDay = 'Sunday';

  final _editNamedDayController = TextEditingController();
  final _sundayController = TextEditingController();
  final _mondayController = TextEditingController();
  final _tuesdayController = TextEditingController();
  final _wednesdayController = TextEditingController();
  final _thursdayController = TextEditingController();
  final _fridayController = TextEditingController();
  final _saturdayController = TextEditingController();

  @override
  void initState() {
    super.initState();

    templateCubit.getTemplateDetails(widget.template.id!);
    exercisesCubit.getBodyPartExerciseLibrary(part: _selectedBodyPart, templateID: widget.template.id!);
    viewDayExerciseCubit.getExercisesDay(day: _selectedDay, templateID: widget.template.id!);
    _updateDayName();
  }

  void _updateDayName() {
    if (_selectedDay == 'Sunday') {
      _editNamedDayController.text = widget.template.sunday!;
    } else if (_selectedDay == 'Monday') {
      _editNamedDayController.text = widget.template.monday!;
    } else if (_selectedDay == 'Tuesday') {
      _editNamedDayController.text = widget.template.tuesday!;
    } else if (_selectedDay == 'Wednesday') {
      _editNamedDayController.text = widget.template.wednesday!;
    } else if (_selectedDay == 'Thursday') {
      _editNamedDayController.text = widget.template.thursday!;
    } else if (_selectedDay == 'Friday') {
      _editNamedDayController.text = widget.template.friday!;
    } else if (_selectedDay == 'Saturday') {
      _editNamedDayController.text = widget.template.saturday!;
    }
  }

  void _beforeUpdateDayName() {
    if (_selectedDay == 'Sunday') {
      _sundayController.text = _editNamedDayController.text;
      _mondayController.text = widget.template.monday!;
      _tuesdayController.text = widget.template.tuesday!;
      _wednesdayController.text = widget.template.wednesday!;
      _thursdayController.text = widget.template.thursday!;
      _fridayController.text = widget.template.friday!;
      _saturdayController.text = widget.template.saturday!;
    } else if (_selectedDay == 'Monday') {
      _sundayController.text = widget.template.sunday!;
      _mondayController.text = _editNamedDayController.text;
      _tuesdayController.text = widget.template.tuesday!;
      _wednesdayController.text = widget.template.wednesday!;
      _thursdayController.text = widget.template.thursday!;
      _fridayController.text = widget.template.friday!;
      _saturdayController.text = widget.template.saturday!;
    } else if (_selectedDay == 'Tuesday') {
      _sundayController.text = widget.template.sunday!;
      _mondayController.text = widget.template.monday!;
      _tuesdayController.text = _editNamedDayController.text;
      _wednesdayController.text = widget.template.wednesday!;
      _thursdayController.text = widget.template.thursday!;
      _fridayController.text = widget.template.friday!;
      _saturdayController.text = widget.template.saturday!;
    } else if (_selectedDay == 'Wednesday') {
      _sundayController.text = widget.template.sunday!;
      _mondayController.text = widget.template.monday!;
      _tuesdayController.text = widget.template.tuesday!;
      _wednesdayController.text = _editNamedDayController.text;
      _thursdayController.text = widget.template.thursday!;
      _fridayController.text = widget.template.friday!;
      _saturdayController.text = widget.template.saturday!;
    } else if (_selectedDay == 'Thursday') {
      _sundayController.text = widget.template.sunday!;
      _mondayController.text = widget.template.monday!;
      _tuesdayController.text = widget.template.tuesday!;
      _wednesdayController.text = widget.template.wednesday!;
      _thursdayController.text = _editNamedDayController.text;
      _fridayController.text = widget.template.friday!;
      _saturdayController.text = widget.template.saturday!;
    } else if (_selectedDay == 'Friday') {
      _sundayController.text = widget.template.sunday!;
      _mondayController.text = widget.template.monday!;
      _tuesdayController.text = widget.template.tuesday!;
      _wednesdayController.text = widget.template.wednesday!;
      _thursdayController.text = widget.template.thursday!;
      _fridayController.text = _editNamedDayController.text;
      _saturdayController.text = widget.template.saturday!;
    } else if (_selectedDay == 'Saturday') {
      _sundayController.text = widget.template.sunday!;
      _mondayController.text = widget.template.monday!;
      _tuesdayController.text = widget.template.tuesday!;
      _wednesdayController.text = widget.template.wednesday!;
      _thursdayController.text = widget.template.thursday!;
      _fridayController.text = widget.template.friday!;
      _saturdayController.text = _editNamedDayController.text;
    }

    // update the template
    Template template = Template(
      id: widget.template.id,
      name: widget.template.name,
      is_active: widget.template.is_active,
      sunday: _sundayController.text,
      monday: _mondayController.text,
      tuesday: _tuesdayController.text,
      wednesday: _wednesdayController.text,
      thursday: _thursdayController.text,
      friday: _fridayController.text,
      saturday: _saturdayController.text,
    );

    templateCubit.updateTemplateDaysName(template);
    templateCubit.getTemplateDetails(widget.template.id!);
  }

  void _deleteTemplate() {
    //templateCubit.deleteTemplate(widget.template.id!);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemplateCubit, TemplateState>(
      bloc: templateCubit,
      builder: (context, state) {
        if (state is TemplateDetailLoadingState ||
            state is TemplateLoadingState) {
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            )),
          );
        } else if (state is TemplateDetailLoaded) {
          widget.template = state.template;
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
                              color: Colors.white,
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
                              print(
                                  'Should show a dialog to update the template');
                              // _showUpdateTemplateDialog(context);
                              _showUpdateTemplateDialog(context);
                            },
                            child: const Text('Update',
                                style: TextStyle(fontSize: 16)),
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
                    icon:
                        const Icon(Icons.delete, color: Colors.white, size: 30),
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
        } else {
          templateCubit.getTemplateDetails(widget.template.id!);
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: theme_green,
              backgroundColor: theme_pink,
            )),
          );
        }
      },
    );
  }


  // First tab
  Widget _currentPlanContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DayDropdown(
              onChanged: (String newValue) {
                _selectedDay = newValue;
                _updateDayName();
                viewDayExerciseCubit.getExercisesDay(
                    day: newValue, templateID: widget.template.id!);
              },
              color: Colors.black,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: primary_decoration,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                // search field
                children: [
                  // adding floating button

                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _editNamedDayController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter Day Name',
                            fillColor: inputField_color,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      IconButton.filled(
                        onPressed: () {
                          _beforeUpdateDayName();
                        },
                        icon: const Icon(Icons.edit),
                        color: theme_green,
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            _buildDayExercises(),
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
                      exercisesCubit.getBodyPartExerciseLibrary(
                          part: newValue, templateID: widget.template.id!);
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
                    templateId: widget.template.id!,
                    id: exercise.id,
                    name: exercise.name,
                    bodyPart: exercise.bodyPart,
                    equipment: exercise.equipment,
                    gifUrl: exercise.gifUrl,
                    target: exercise.target,
                    instructions: exercise.instructions,
                    secondaryMuscles: exercise.secondaryMuscles,
                    gradient: LinearGradient(
                      colors: [theme_pink, theme_green],
                      tileMode: TileMode.clamp,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
              ],
            ),
          );
        } else if (state is ExerciseErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ExerciseAddedState) {
          exercisesCubit.getBodyPartExerciseLibrary(
              part: _selectedBodyPart, templateID: widget.template.id!);
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }

  BlocBuilder<ViewDayExerciseCubit, ViewDayExerciseState> _buildDayExercises() {
    return BlocBuilder<ViewDayExerciseCubit, ViewDayExerciseState>(
      bloc: viewDayExerciseCubit,
      builder: (context, state){
        if (state is ExercisesDayLoadingState) {
          return  Center(child: CircularProgressIndicator(
            color: theme_green,
            backgroundColor: theme_pink,
          ));
        } else if (state is ExerciseDayLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                for (var exercise in state.exercises)
                  ViewDayExerciseItem(
                    templateId: widget.template.id!,
                    id: exercise.id,
                    name: exercise.name,
                    bodyPart: exercise.bodyPart,
                    equipment: exercise.equipment,
                    gifUrl: exercise.gifUrl,
                    target: exercise.target,
                    instructions: exercise.instructions,
                    secondaryMuscles: exercise.secondaryMuscles,
                    gradient: LinearGradient(
                      colors: [theme_pink, theme_green],
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
        } else if (state is ExerciseDayEmptyState) {
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
                Text('No exercises added yet',
                    style: TextStyle(
                      color: theme_darkblue,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),

          );
        } else if (state is ExerciseDayErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is ExerciseDayAddedState) {
          viewDayExerciseCubit.getExercisesDay(day: _selectedDay, templateID: widget.template.id!);
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }

}


void _showUpdateTemplateDialog(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  bool isActivated = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Update The Template',
          style: TextStyle(color: theme_darkblue),
        ),
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter new template name',
                      fillColor: inputField_color,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Activate Plan?',
                          style: TextStyle(color: theme_grey)),
                      Switch(
                        value: isActivated,
                        onChanged: (bool value) {
                          isActivated = value;
                          (context as Element).markNeedsBuild();
                        },
                        activeColor: theme_green,
                        inactiveThumbColor: theme_grey,
                        inactiveTrackColor: theme_grey.withOpacity(0.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: -45,
              top: -100,
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [theme_pink, theme_darkblue],
                    tileMode: TileMode.clamp,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Icon(
                  Icons.edit,
                  color: primary_color,
                  size: 34.0,
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel', style: TextStyle(color: theme_red)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Submit', style: TextStyle(color: theme_green)),
            onPressed: () {
              // TOdo submit logic here
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
