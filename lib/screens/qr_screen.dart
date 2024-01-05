import 'package:cbhsapp/provider/user_provider.dart';
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
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
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
