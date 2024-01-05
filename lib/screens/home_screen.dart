import 'package:cbhsapp/screens/qr_screen.dart';
import 'package:cbhsapp/style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  static final List<Widget> _pages = <Widget>[
    const QrCodeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈페이지'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedPage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.qr_code), label: '입출입 QR코드'),
          BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: '학사 식단'),
        ],
        currentIndex: _selectedPage,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColor.main,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
