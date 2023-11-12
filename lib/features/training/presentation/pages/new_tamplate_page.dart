import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/themes/common_styles.dart';
import '../../data/datasources/mock_data_source.dart';
import '../../data/models/day_model.dart';
import '../../data/models/exercise_model.dart';
import '../../data/models/temp_template_model.dart';
import '../../data/repositories/exercise_repository_impl.dart';
import '../../data/repositories/temp_template_repository_impl.dart';
import '../widgets/newTamplate/day_card.dart';
import '../widgets/newTamplate/exercise_selection_dialog.dart';

class NewTemplatePage extends StatefulWidget {
  NewTemplatePage({Key? key}) : super(key: key);

  @override
  _NewTemplatePageState createState() => _NewTemplatePageState();
}

class _NewTemplatePageState extends State<NewTemplatePage> {
  final _controller = PageController();
  double _currentPage = 0;
  final _templateNameController = TextEditingController();

  bool _isLoadingExercises = true;

  late final ExerciseRepository _exerciseRepository;
  List<ExerciseModel> _allExercises= []; // To store all available exercises

  // Initialize _dayModels as an empty list right away
  List<DayModel> _dayModels = [];

  late final TempTemplateRepository _templateRepository;

  @override
  void initState() {
    super.initState();

    // Initialize the MockDataSource and TemplateRepository
    MockDataSource mockDataSource = MockDataSource();
    _templateRepository = TempTemplateRepository(mockDataSource);

    // Initialize the ExerciseRepository
    _exerciseRepository = ExerciseRepository(mockDataSource);

    // Initialize _dayModels with one DayModel item immediately
    _dayModels = [DayModel(dayId: 'Day1', dayName: "Day 1", exercises: [])];

    // Fetch all exercises asynchronously
    _initializeData();

    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page ?? 0;
      });
    });
  }

  void _initializeData() async {
    try {
      var exercises = await _exerciseRepository.getExercises();
      setState(() {
        _allExercises = exercises;
        _isLoadingExercises = false;
      });
      print("Exercises fetched, isLoadingExercises set to false");
    }
    catch (error) {
      print('Error fetching exercises: $error');
      // You might want to handle the error state as well
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }


  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text('New Template', style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [

        GestureDetector(
          onTap: () => _saveTemplate(),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            //alignment: Alignment.center,
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,

              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildBody() {
    return Column(
      children: [
        _buildTemplateNameInput(),
        _buildPageView(),
        _buildBottomRow(),

      ],
    );
  }

  Padding _buildTemplateNameInput() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _templateNameController,
        decoration: InputDecoration(
          hintText: 'Enter Template Name',
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: theme_darkblue),
          ),
        ),
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Expanded _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        itemCount: _dayModels.length,
        itemBuilder: (context, index) {
          return DayCard(
            day: _dayModels[index].dayName,
            onAddExercise: () => _showExerciseSelectionDialog(context, index),
            exercises: _dayModels[index].exercises,
          );
        },
      ),
    );
  }

  Padding _buildBottomRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPageIndicator(),
          SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: theme_green),
            onPressed: () => _addNewDay(),
            child: Text("Add Day"),
          ),
        ],
      ),
    );
  }

  Row _buildPageIndicator() {
    return Row(
      children: List.generate(
        _dayModels.length,
            (index) => Container(
          width: 17,
          height: 33,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: _currentPage.round() == index ? theme_green : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  void _showExerciseSelectionDialog(BuildContext context, int dayIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return ExerciseSelectionDialog(
          day: _dayModels[dayIndex].dayName,
          allExercises: _allExercises,
          isLoading: _isLoadingExercises, // Pass the loading flag
          onSelectedExercises: (List<ExerciseModel> selectedExercises) {
            setState(() {
              _dayModels[dayIndex].exercises.clear();
              _dayModels[dayIndex].exercises.addAll(selectedExercises);
            });
          },
        );
      },
    );
  }






  void _addNewDay() {
    setState(() {
      _dayModels.add(DayModel(dayId: 'ID', dayName: "Day ${_dayModels.length + 1}", exercises: []));
    });
  }

  void _saveTemplate() {
    // Implement logic to save the template
    TempTemplateModel newTemplate = TempTemplateModel(
      templateId: 'UniqueID',
      templateName: _templateNameController.text,
      creator: 'UserID',  // Adjust based on your user management
      isCustomizable: true,
      days: _dayModels,
    );
    // Use _templateRepository to save the new template
  }
}
