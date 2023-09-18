import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Profile'),
      body: const Column(
        children: [
          Text('data'),
        ],
      ),
    );
  }
}
