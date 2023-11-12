import 'day_model.dart';

class TempTemplateModel {
  final String templateId;
  final String templateName;
  final String creator;
  final bool isCustomizable;
  final List<DayModel> days;

  TempTemplateModel({
    required this.templateId,
    required this.templateName,
    required this.creator,
    required this.isCustomizable,
    required this.days,
  });

  factory TempTemplateModel.fromJson(Map<String, dynamic> json) {
    return TempTemplateModel(
      templateId: json['templateId'],
      templateName: json['templateName'],
      creator: json['creator'],
      isCustomizable: json['isCustomizable'],
      days: List<DayModel>.from(json['days'].map((x) => DayModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'templateId': templateId,
      'templateName': templateName,
      'creator': creator,
      'isCustomizable': isCustomizable,
      'days': days.map((x) => x.toJson()).toList(),
    };
  }
}
