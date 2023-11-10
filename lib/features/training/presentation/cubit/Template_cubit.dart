import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/template_model.dart';
import '../../data/repositories/template_repository.dart';

class TemplateState {
  final bool isLoading;
  final List<TemplateModel> templates;
  final String error;

  TemplateState({this.isLoading = true, this.templates = const [], this.error = ''});
}

class TemplateCubit extends Cubit<TemplateState> {
  final TemplateRepository _templateRepository;

  TemplateCubit(this._templateRepository) : super(TemplateState());

  void fetchTemplates() async {
    try {
      var templates = await _templateRepository.getTemplates();
      emit(TemplateState(isLoading: false, templates: templates));
    } catch (e) {
      emit(TemplateState(isLoading: false, error: e.toString()));
    }
  }
}
