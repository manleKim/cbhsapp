import 'package:cbhsapp/provider/user_manage_provider.dart';
import 'package:cbhsapp/provider/user_provider.dart';
import 'package:cbhsapp/screens/home_screen.dart';
import 'package:cbhsapp/services/login.dart';
import 'package:flutter/material.dart';
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
              decoration: const InputDecoration(labelText: 'Academic Number'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Replace this with your login logic
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
      final qrData = await Login.postLogin(academicNumber, password);
      currentContext.read<UserProvider>().setUser(academicNumber, password);
      currentContext.read<UserProvider>().setQRdata(qrData);
      currentContext
          .read<UserManageProvider>()
          .setUser(academicNumber, password);
      currentContext.read<UserManageProvider>().getStudentNumber();
      Navigator.push(currentContext,
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      print(e.toString());
    }
  }
}
