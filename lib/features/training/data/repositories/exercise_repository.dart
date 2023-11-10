import '../datasources/mock_data_source.dart';
import '../models/exercise_model.dart';

class ExerciseRepository {
  final MockDataSource _dataSource;

  ExerciseRepository(this._dataSource);

  Future<List<ExerciseModel>> getExercises() async {
    return _dataSource.getExercises();
  }
}
