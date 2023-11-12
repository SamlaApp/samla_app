import '../datasources/mock_data_source.dart';
import '../models/temp_template_model.dart';

class TempTemplateRepository {
  final MockDataSource _dataSource;

  TempTemplateRepository(this._dataSource);

  Future<List<TempTemplateModel>> getTemplates() async {
    return _dataSource.getTemplates();
  }

// Add more methods as needed, such as getting a specific template or updating a template
}
