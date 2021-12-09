import 'package:flutter/material.dart';

import 'package:shopping_app_project/widgets/loading_Screen.dart';

class Splash_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Loading_Screen()],
      ),
    );
  }
}
