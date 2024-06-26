import 'package:cbhsapp/models/reassess_element_model.dart';
import 'package:cbhsapp/provider/user_manage_provider.dart';
import 'package:cbhsapp/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  List<ReassessElementModel> reassessList = [];

  @override
  void initState() {
    super.initState();
    Provider.of<UserManageProvider>(context, listen: false).refreshSession();
    Provider.of<UserManageProvider>(context, listen: false)
        .refreshReassessList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
      ),
      body: Column(
        children: [
          Consumer<UserManageProvider>(
            builder: (context, userManageProvider, child) {
              String academicNumber = userManageProvider.academicNumber;
              String password = userManageProvider.password;
              String studentNumber = userManageProvider.studentNumber;
              String studentName = userManageProvider.studentName;
              String session = userManageProvider.session;
              List<ReassessElementModel> reassessList =
                  userManageProvider.reassessList;

              return Center(
                child: Column(
                  children: [
                    Text(academicNumber),
                    Text(password),
                    Text(studentNumber),
                    Text(studentName),
                    Text(session),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: reassessList.length,
                        itemBuilder: (context, index) {
                          ReassessElementModel reassessElement =
                              reassessList[index];
                          bool isSatisfied = reassessElement.isSatisfied();
                          return ListTile(
                            title: Text(reassessElement.name),
                            subtitle: isSatisfied
                                ? Text(
                                    '${reassessElement.count}/${reassessElement.total}',
                                    style: const TextStyle(color: Colors.blue),
                                  )
                                : Text(
                                    '${reassessElement.count}/${reassessElement.total}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                            // Customize the appearance as needed
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                const FlutterSecureStorage storage = FlutterSecureStorage();
                storage.delete(key: 'academicNumber');
                storage.delete(key: 'password');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              child: const Text('로그아웃')),
        ],
      ),
    );
  }
}
