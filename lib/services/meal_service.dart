import 'package:cbhsapp/models/meal_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class MealService {
  static final String baseUrl = (dotenv.env['MEAL_URL'] as String);
  static final dateRegex = RegExp(r'[^0-9]');
  static final unescapeRegex = RegExp(r'\n|\t');

  //오늘의 식사 가져오기
  static Future<MealModel> getTodayMeal() async {
    final response = await http.get(Uri.parse('$baseUrl?searchWeek=0'));
    final document = html_parser.parse(response.body);
    final fplans = document.querySelectorAll('.fplan_plan');
    final fplansParsed =
        fplans.map((fplan) => fplan.querySelectorAll('p')).toList();

    List<MealModel> parseMeals = _parseMeals(fplansParsed);

    final result =
        parseMeals.firstWhere((meal) => meal.isSameDate(DateTime.now()));

    return result;
  }

  //요번주 식사들 가져오기
  static Future<List<MealModel>> getThisWeekMeals() async {
    final response = await http.get(Uri.parse('$baseUrl?searchWeek=0'));
    final document = html_parser.parse(response.body);
    final fplans = document.querySelectorAll('.fplan_plan');
    final fplansParsed =
        fplans.map((fplan) => fplan.querySelectorAll('p')).toList();

    List<MealModel> result = _parseMeals(fplansParsed);

    return result;
  }

  //다음주 식사 가져오기
  static Future<List<MealModel>> getNextWeekMeals() async {
    final response = await http.get(Uri.parse('$baseUrl?searchWeek=1'));
    final document = html_parser.parse(response.body);

    final fplans = document.querySelectorAll('.fplan_plan');
    final fplansParsed =
        fplans.map((fplan) => fplan.querySelectorAll('p')).toList();

    List<MealModel> result = _parseMeals(fplansParsed);

    return result;
  }

  //HTML a 요소들 => MealModel로 parse하는 함수
  static List<MealModel> _parseMeals(List<List<Element>> fplansParsed) {
    final result = fplansParsed.map((fplan) {
      final fullDate =
          '20${fplan[0].querySelector('a')!.text}'; // ex) 2024.01.01 (월)
      final date = fullDate.replaceAll(dateRegex, ''); // ex) 20240101
      final breakfast =
          fplan[1].text.replaceAll(unescapeRegex, '').split(','); //아침
      final lunch = fplan[2].text.replaceAll(unescapeRegex, '').split(','); //점심
      final dinner =
          fplan[3].text.replaceAll(unescapeRegex, '').split(','); //저녁
      final json = {
        'fullDate': fullDate,
        'date': date,
        'breakfast': breakfast,
        'lunch': lunch,
        'dinner': dinner
      };
      return MealModel.fromJson(json);
    }).toList();
    return result;
  }
}
