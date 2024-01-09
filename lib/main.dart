import 'package:cbhsapp/provider/meal_provider.dart';
import 'package:cbhsapp/provider/user_manage_provider.dart';
import 'package:cbhsapp/provider/user_provider.dart';
import 'package:cbhsapp/screens/login_screen.dart';
import 'package:cbhsapp/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => UserProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => MealProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => UserManageProvider()),
      ],
      child: MaterialApp(
        title: 'CBHS Dormitory App',
        theme: ThemeData(
          fontFamily: 'Gmarket',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.main),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
