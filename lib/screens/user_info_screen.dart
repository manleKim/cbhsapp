import 'package:cbhsapp/provider/user_manage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserManageProvider>(context, listen: false).refreshSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: Consumer<UserManageProvider>(
        builder: (context, userManageProvider, child) {
          String academicNumber = userManageProvider.academicNumber;
          String password = userManageProvider.password;
          String studentNumber = userManageProvider.studentNumber;
          String studentName = userManageProvider.studentName;
          String session = userManageProvider.session;

          return Center(
            child: Column(
              children: [
                Text(academicNumber),
                Text(password),
                Text(studentNumber),
                Text(studentName),
                Text(session),
              ],
            ),
          );
        },
      ),
    );
  }
}
