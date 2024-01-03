import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _academicNumberController = TextEditingController();
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
  void _performLogin() {
    String academicNumber = _academicNumberController.text;
    String password = _passwordController.text;

    // Implement your authentication logic here
    if (academicNumber.isNotEmpty && password.isNotEmpty) {
      // Successful login
      print('Login successful! Academic Number: $academicNumber');
    } else {
      // Failed login
      print('Login failed. Please enter valid credentials.');
    }
  }
}

