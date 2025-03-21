import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLine;
  final TextOverflow? textOverflow;
  final TextDirection? textDirection;
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final Color? decorationColor;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.maxLine,
    this.textAlign,
    this.textOverflow,
    this.color,
    this.textDirection,
    this.textDecoration,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLine,
      softWrap: true,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? Colors.black,
          decoration: textDecoration,
          decorationColor:
              decorationColor ?? Colors.red // Apply the decorationColor here
          ),
    );
  }
}
