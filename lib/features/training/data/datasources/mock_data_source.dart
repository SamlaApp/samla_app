import '../models/day_model.dart';
import '../models/exercise_model.dart';
import '../models/temp_template_model.dart';

class MockDataSource {
  // Mock Templates
  final List<TempTemplateModel> _templates = [
    TempTemplateModel(
      templateId: '1',
      templateName: 'Strength Training',
      creator: 'User123',
      isCustomizable: true,
      days: [
        DayModel(
          dayId: '1',
          dayName: 'Chest Day',
          exercises: [
            ExerciseModel(
              id: '1',
              name: 'Bench Press',
              bodyPart: 'Chest',
              equipment: 'Barbell',
              gifUrl: 'https://v2.exercisedb.io/image/mAk0hBpwaU6EwP',
              target: 'Chest Muscles',
            ),
            // Add more exercises
          ],
        ),
        // Add more days
      ],
    ),
    // Add more templates
  ];

  Future<List<TempTemplateModel>> getTemplates() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    return _templates;
  }

  final List<ExerciseModel> _exercises = [
    ExerciseModel(
      id: '1',
      name: 'Push Up',
      bodyPart: 'Chest',
      equipment: 'None',
      gifUrl: 'https://v2.exercisedb.io/image/mAk0hBpwaU6EwP',
      target: 'Chest Muscle',
    ),
    // Add more mock exercises
  ];

  // Add this method
  Future<List<ExerciseModel>> getExercises() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    return _exercises;
  }

// more functions to get specific templates or days if needed
}
