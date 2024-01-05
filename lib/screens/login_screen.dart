import 'package:cbhsapp/services/login.dart';
import 'package:flutter/material.dart';

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

    try {
      final htmlCode = await Login.postLogin(academicNumber, password);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => MyWidget(string: htmlCode)));
    } catch (e) {
      print(e.toString());
    }
  }
}

class MyWidget extends StatelessWidget {
  final String string;
  const MyWidget({super.key, required this.string});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: Text(string)),
    );
  }
}
