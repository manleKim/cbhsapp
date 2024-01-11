import 'package:cbhsapp/provider/user_provider.dart';
import 'package:cbhsapp/screens/user_info_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).refreshQRdata();
  }

  @override
  Widget build(BuildContext context) {
    //UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('입출입 QR 코드'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userInfo');
              },
              icon: const Icon(Icons.account_circle_outlined)),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          String qrData = userProvider.qrData;

          return Center(
            child: Column(
              children: [
                QrImageView(
                  data: qrData,
                  size: 300,
                ),
                Text(qrData),
                ElevatedButton(
                  onPressed: () {
                    userProvider.refreshQRdata();
                  },
                  child: const Text('Refresh'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
