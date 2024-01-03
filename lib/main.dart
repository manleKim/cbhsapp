import 'package:cbhsapp/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBHS Dormitory App',
      theme: ThemeData(
        fontFamily: 'Gmarket',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.main),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시작'),
      ),
      body: Container(),
    );
  }
}

