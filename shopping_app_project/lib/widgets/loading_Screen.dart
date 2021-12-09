import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.purple.shade100,
        child: SpinKitFadingCircle(
          color: Colors.black,
          size: 30,
        ));
  }
}
