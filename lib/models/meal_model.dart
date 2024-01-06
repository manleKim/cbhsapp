class MealModel {
  final String fullDate;
  final DateTime date;
  final List<String> breakfast;
  final List<String> lunch;
  final List<String> dinner;

  MealModel({
    required this.fullDate,
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  MealModel.fromJson(Map<String, dynamic> json)
      : fullDate = json['fullDate'],
        date = DateTime.parse(json['date']),
        breakfast = List<String>.from(json['breakfast']),
        lunch = List<String>.from(json['lunch']),
        dinner = List<String>.from(json['dinner']);

  bool isSameDate(DateTime otherDate) {
    return date.year == otherDate.year &&
        date.month == otherDate.month &&
        date.day == otherDate.day;
  }
}
