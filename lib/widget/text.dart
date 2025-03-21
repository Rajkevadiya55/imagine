import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagine/common/color_constant/color_constant.dart';
import 'package:imagine/helper/helper.dart';


class CommonText extends StatefulWidget {
  String text;
  double fontSize;
  Color? color;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  int? maxLines;
  TextDecoration? decoration;
  TextAlign? textAlign;

  CommonText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color,
    this.fontWeight,
    this.overflow,
    this.maxLines,
    this.decoration,
    this.textAlign,
  });

  @override
  State<CommonText> createState() => _CommonTextState();
}

class _CommonTextState extends State<CommonText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      style: GoogleFonts.poppins(
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight ?? FontWeight.w400,
        color: (themeMode == false)
            ? widget.color == const Color(0xff1E4387) ||
                    widget.color == const Color(0xff0BAFD4)
                ? widget.color
                : widget.color == const Color(0xff959FA3)
                    ? widget.color
                    : widget.color ?? AppColors.black
            : (themeMode == true)
                ? widget.color == const Color(0xff1E4387) ||
                        widget.color == const Color(0xff0BAFD4)
                    ? widget.color
                    : widget.color == const Color(0xff959FA3)
                        ? widget.color
                        : widget.color ?? AppColors.white
                : null,
        decoration: widget.decoration,
      ),
    );
  }
}
