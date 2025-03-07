import 'package:flutter/material.dart';
import 'package:gps_attendance/features/authentication/widgets/account_card.dart';
import 'package:gps_attendance/widgets/appbar.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Register"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Type",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Choose the type of account you want to setup",
                  style: TextStyle(fontSize: 12, color: Color(0xFF71727A)),
                ),
                const SizedBox(height: 10),
                accountCard(employee: true),
                const SizedBox(height: 10),
                accountCard(employee: false)
              ],
            )
          ],
        ),
      ),
    );
  }
}
