import 'package:cbhsapp/models/meal_model.dart';
import 'package:cbhsapp/provider/meal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({super.key});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MealProvider>(context, listen: false).setMeals();
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('학사 식단'),
        automaticallyImplyLeading: false,
      ),
      body: mealProvider.thisWeekMeals.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display today's meal
                ListTile(
                  title: Text(mealProvider.todayMeal.fullDate),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Breakfast: ${mealProvider.todayMeal.breakfast.join(', ')}'),
                      Text('Lunch: ${mealProvider.todayMeal.lunch.join(', ')}'),
                      Text(
                          'Dinner: ${mealProvider.todayMeal.dinner.join(', ')}'),
                    ],
                  ),
                ),

                // Display this week's meals
                Expanded(
                  child: ListView.builder(
                    itemCount: mealProvider.thisWeekMeals.length,
                    itemBuilder: (context, index) {
                      MealModel meal = mealProvider.thisWeekMeals[index];

                      return ListTile(
                        title: Text(meal.fullDate),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Breakfast: ${meal.breakfast.join(', ')}'),
                            Text('Lunch: ${meal.lunch.join(', ')}'),
                            Text('Dinner: ${meal.dinner.join(', ')}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: mealProvider.nextWeekMeals.length,
                    itemBuilder: (context, index) {
                      MealModel meal = mealProvider.nextWeekMeals[index];

                      return ListTile(
                        title: Text(meal.fullDate),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Breakfast: ${meal.breakfast.join(', ')}'),
                            Text('Lunch: ${meal.lunch.join(', ')}'),
                            Text('Dinner: ${meal.dinner.join(', ')}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
