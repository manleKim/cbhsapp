import 'package:cbhsapp/provider/meal_provider.dart';
import 'package:cbhsapp/provider/user_manage_provider.dart';
import 'package:cbhsapp/provider/user_provider.dart';
import 'package:cbhsapp/screens/home_screen.dart';
import 'package:cbhsapp/screens/login_screen.dart';
import 'package:cbhsapp/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAutoLogin = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkAutoLogin(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data == true
              ? const HomeScreen()
              : const LoginScreen();
        } else {
          return const Scaffold(
            body: Text('스플래쉬 화면입니당'),
          );
        }
      },
    );
  }

  Future<bool> _checkAutoLogin(BuildContext context) async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? academicNumber = await secureStorage.read(key: 'academicNumber');
    String? password = await secureStorage.read(key: 'password');
    if (academicNumber != null && password != null) {
      try {
        context.read<UserProvider>().setUser(academicNumber, password);
        context.read<UserManageProvider>().setUser(academicNumber, password);
        context.read<UserManageProvider>().getStudentInfo();

        return true;
      } catch (e) {
        print(e.toString());
        return false;
      }
    }

    return false;
  }
}
