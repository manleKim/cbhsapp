import 'package:cbhsapp/provider/user_manage_provider.dart';
import 'package:cbhsapp/provider/user_provider.dart';
import 'package:cbhsapp/screens/home_screen.dart';
import 'package:cbhsapp/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _academicNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _autoLogin = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _academicNumberController,
              decoration: const InputDecoration(labelText: '학사번호'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: '비밀번호'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('자동로그인'),
                Checkbox(
                  value: _autoLogin,
                  onChanged: (value) {
                    setState(() {
                      _autoLogin = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _performLogin();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() async {
    String academicNumber = _academicNumberController.text.trim();
    String password = _passwordController.text.trim();

    BuildContext currentContext = context;

    try {
      final qrData = await LoginService.postLogin(academicNumber, password);
      currentContext.read<UserProvider>().setUser(academicNumber, password);
      currentContext.read<UserProvider>().setQRdata(qrData);
      currentContext
          .read<UserManageProvider>()
          .setUser(academicNumber, password);
      currentContext.read<UserManageProvider>().getStudentInfo();
      if (_autoLogin) {
        const FlutterSecureStorage secureStorage = FlutterSecureStorage();
        secureStorage.write(key: 'academicNumber', value: academicNumber);
        secureStorage.write(key: 'password', value: password);
      }
      Navigator.push(currentContext,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
      _academicNumberController.clear();
      _passwordController.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
