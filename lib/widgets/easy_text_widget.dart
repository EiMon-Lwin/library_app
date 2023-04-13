import 'package:flutter/material.dart';

class EasyTextWidget extends StatelessWidget {
  const EasyTextWidget( {
     Key? key,
    required this.text,

    this.textColor = Colors.black,
    this.fontSize = 15,
    this.textDecoration = TextDecoration.none,
    this.fontWeight = FontWeight.w300,

  }) : super(key: key);
  final String text;
  final Color textColor;
  final TextDecoration textDecoration;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: textColor,
          decoration: textDecoration,
          fontWeight: fontWeight,
          fontSize: fontSize),
    );
  }
}
