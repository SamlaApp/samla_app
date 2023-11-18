part of 'template_cubit.dart';


abstract class TemplateState extends Equatable {
  const TemplateState();

  @override
  List<Object> get props => [];
}

class TemplateInitial extends TemplateState {}

class TemplateLoadingState extends TemplateState {}

class TemplateErrorState extends TemplateState {
  final String message;

  const TemplateErrorState(this.message);

  @override
  List<Object> get props => [message];
}


class TemplateEmptyState extends TemplateState {}

class TemplateLoaded extends TemplateState {
  final List<Template> templates;
  final List<Template> selectedTemplates;

  const TemplateLoaded(this.templates, this.selectedTemplates);

  @override
  List<Object> get props => [templates, selectedTemplates];
}

// ActiveTemplateLoaded
class ActiveTemplateLoaded extends TemplateState {
  final Template template;

  const ActiveTemplateLoaded(this.template);

  @override
  List<Object> get props => [template];
}
