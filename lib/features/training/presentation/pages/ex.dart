class Exercise {
  final String name;
  final String? description;

  Exercise({required this.name, this.description});
}

class Routine {
  final String title;
  final List<Exercise> exercises;

  Routine({required this.title, required this.exercises});
}

final List<Routine> dummyRoutines = [
  Routine(
    title: 'Push Routine',
    exercises: [
      Exercise(name: 'Push-Ups', description: 'Do 15 push-ups'),
      Exercise(name: 'Bench Press', description: 'Lift weights on a bench lkajhfldakj laskjdfhalksjf '),
      Exercise(name: 'Dips', description: 'Do 12 dips'),
    ],
  ),
  Routine(
    title: 'Lose Weight Routine',
    exercises: [
      Exercise(name: 'Cardio', description: 'Run for 30 minutes'),
      Exercise(name: 'Healthy Diet', description: 'Eat balanced meals'),
      Exercise(name: 'Planks', description: 'Hold for 1 minute'),
    ],
  ),
  Routine(
    title: 'Gain Weight Routine',
    exercises: [
      Exercise(name: 'Weightlifting', description: 'Lift heavy weights'),
      Exercise(name: 'Protein Intake', description: 'Consume more protein'),
      Exercise(name: 'Squats', description: 'Do 10 squats'),
    ],
  ),
];