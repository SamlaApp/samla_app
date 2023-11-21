import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:samla_app/features/training/domain/entities/Template.dart';
import 'package:samla_app/features/training/domain/repositories/template_repository.dart';

part 'template_state.dart';

class TemplateCubit extends Cubit<TemplateState> {
  final TemplateRepository repository;

  TemplateCubit(this.repository) : super(TemplateInitial());

  Future<void> getAllTemplates() async {
    emit(TemplateLoadingState());
    final result = await repository.getAllTemplates();
    result.fold(
        (failure) =>
            emit(const TemplateErrorState('Failed to fetch templates')),
        (templates) {
      if (templates.isEmpty) {
        print('empty');
        emit(TemplateEmptyState());
        return;
      }
      emit(TemplateLoaded(templates.cast<Template>(), []));
    });
  }

  Future<void> createTemplate(Template template) async {
    emit(TemplateLoadingState());
    final result = await repository.createTemplate(template);
    result.fold(
        (failure) =>
            emit(const TemplateErrorState('Failed to create template')),
        (template) {
      emit(TemplateCreatedState(template));
    });
  }

  Future<void> activeTemplate() async {
    emit(TemplateLoadingState());
    final result = await repository.activeTemplate();
    result.fold(
        (failure) =>
            emit(const TemplateErrorState('Failed to active template')),
        (template) {
      if (template.id == null) {
        emit(TemplateEmptyState());
        return;
      }
      emit(ActiveTemplateLoaded(template));
    });
  }

  Future<void> getTemplateDetails(int id) async {
    emit(TemplateDetailLoadingState());
    final result = await repository.getTemplateDetails(id);
    result.fold(
        (failure) =>
            emit(const TemplateErrorState('Failed to fetch template details')),
        (template) {
      emit(TemplateDetailLoaded(template));
    });
  }

  Future<void> updateTemplateDaysName(Template template) async {
    emit(TemplateLoadingState());
    final result = await repository.updateTemplateDaysName(template);
    result.fold(
        (failure) =>
            emit(const TemplateErrorState('Failed to update template')),
        (template) {
      emit(TemplateCreatedState(template));
    });
  }
}
