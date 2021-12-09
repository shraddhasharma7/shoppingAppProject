//import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_Text.dart';

class Custom_Button extends StatelessWidget {
  final String? text;
  final Color? txtColor;
  final Color? bgColor;
  final Color? shadowColor;
  final VoidCallback? onTap;

  const Custom_Button(
      {Key? key,
      @required this.text,
      this.txtColor,
      this.bgColor,
      this.shadowColor,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: PhysicalModel(
        color: Colors.grey.withOpacity(.4),
        elevation: 2,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColor ?? Colors.black,
            ),
            child: Container(
              margin: EdgeInsets.all(14),
              alignment: Alignment.center,
              child: Custom_Text(
                text: text,
                color: txtColor ?? Colors.white,
                size: 22,
                weight: FontWeight.normal,
              ),
            )),
      ),
    );
  }
}
