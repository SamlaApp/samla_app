import '../datasources/mock_data_source.dart';
import '../models/template_model.dart';

class TemplateRepository {
  final MockDataSource _dataSource;

  TemplateRepository(this._dataSource);

  Future<List<TemplateModel>> getTemplates() async {
    return _dataSource.getTemplates();
  }

// Add more methods as needed, such as getting a specific template or updating a template
}
