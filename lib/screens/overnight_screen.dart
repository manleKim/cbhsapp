import 'package:flutter/material.dart';

class OverNightScreen extends StatefulWidget {
  const OverNightScreen({super.key});

  @override
  State<OverNightScreen> createState() => _OverNightScreenState();
}

class _OverNightScreenState extends State<OverNightScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('외박 신청'),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
