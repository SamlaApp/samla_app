class UserGoals {
  int? id;
  int? userId;
  num? targetWeight;
  num? targetSteps;
  num? targetCalories;

  UserGoals({
    this.id,
    this.userId,
    this.targetWeight,
    this.targetSteps,
    this.targetCalories,
  });

  // constructor
  UserGoals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    targetWeight = json['target_weight'] is String ? num.parse(json['target_weight']) : json['target_weight'];
    targetSteps = json['target_steps'] is String
        ? num.parse(json['target_steps'])
        : json['target_steps'];
    ;
    targetCalories = json['target_calories'] is String
        ? num.parse(json['target_calories'])
        : json['target_calories'];
  }

  // to json

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? 0;
    data['user_id'] = this.userId ?? 0;
    data['target_weight'] = this.targetWeight ?? 0;
    data['target_steps'] = this.targetSteps ?? 0;
    data['target_calories'] = this.targetCalories ?? 0;
    return data;
  }

  // copywith function

  UserGoals copyWith({
    int? id,
    int? userId,
    num? targetWeight,
    num? targetSteps,
    num? targetCalories,
  }) {
    return UserGoals(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      targetWeight: targetWeight ?? this.targetWeight,
      targetSteps: targetSteps ?? this.targetSteps,
      targetCalories: targetCalories ?? this.targetCalories,
    );
  }
}
