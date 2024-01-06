import 'package:flutter/material.dart';
import 'package:cbhsapp/models/meal_model.dart';
import 'package:cbhsapp/services/meal_service.dart';

class MealProvider extends ChangeNotifier {
  MealModel _todayMeal = MealModel(
      fullDate: '오늘의 식단 가져오는 중...',
      date: DateTime.now(),
      breakfast: [],
      lunch: [],
      dinner: []);
  List<MealModel> _thisWeekMeals = [];
  List<MealModel> _nextWeekMeals = [];

  MealModel get todayMeal => _todayMeal;
  List<MealModel> get thisWeekMeals => _thisWeekMeals;
  List<MealModel> get nextWeekMeals => _nextWeekMeals;

  Future<void> setMeals() async {
    try {
      _todayMeal = await MealService.getTodayMeal();
      _thisWeekMeals = await MealService.getThisWeekMeals();
      _nextWeekMeals = await MealService.getNextWeekMeals();
      notifyListeners();
    } catch (error) {
      print('Error fetching meals: $error');
      rethrow;
    }
  }
}
