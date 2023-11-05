import 'dart:convert';
import 'package:samla_app/core/error/exceptions.dart';
import 'package:samla_app/features/nutrition/data/models/nutritionPlan_model.dart';
import 'package:http/http.dart' as http;
import 'package:samla_app/features/nutrition/domain/entities/nutritionPlan.dart';
import 'package:samla_app/core/network/samlaAPI.dart';

abstract class NutritionPlanRemoteDataSource {
  /// Calls the https://samla-api.herokuapp.com/nutritionPlans endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
 Future<List<NutritionPlan>> getAllNutritionPlans();
}

const BASE_URL = 'https://samla.mohsowa.com/api/nutrition';

class NutritionPlanRemoteDataSourceImpl
    implements NutritionPlanRemoteDataSource {
  final http.Client client;

  NutritionPlanRemoteDataSourceImpl({required this.client});

  @override
  Future<List<NutritionPlan>> getAllNutritionPlans() async {
    final res = await samlaAPI(endPoint: '/nutrition/get', method: 'GET');
    final resBody = await res.stream.bytesToString();
    if (res.statusCode == 200) {
      final List<dynamic> nutritionPlans = json.decode(resBody)['nutrition_plans'];
      final List<NutritionPlanModel> convertedPlans = nutritionPlans
          .map((e) => NutritionPlanModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return convertedPlans;
    } else {
      throw ServerException(message: json.decode(resBody)['message']);
    }
  }

}