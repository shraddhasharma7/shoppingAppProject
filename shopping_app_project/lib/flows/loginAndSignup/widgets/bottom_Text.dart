import 'package:flutter/material.dart';

class Bottom_Text_Widget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text1;
  final String? text2;

  const Bottom_Text_Widget({Key? key, this.onTap, this.text1, this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: text1, style: TextStyle(color: Colors.black)),
        TextSpan(text: " $text2", style: TextStyle(color: Colors.blue))
      ])),
    );
  }
}
