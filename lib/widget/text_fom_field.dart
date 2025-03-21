import 'package:flutter/material.dart';
import 'package:imagine/common/color_constant/color_constant.dart';

class CustomTextField extends StatelessWidget {
  final bool? readOnly;
  final String? hintText;
  final Color? hintTextColor;
  final Color? textColor;
  final bool? isPassword;
  final int? minLine;
  final bool? enableInteractiveSelection;
  final bool? enabled;
  final int? maxLength;
  final double? cursorHeight;
  final int? maxLine = 1;
  final Color? cursorColor;
  final Color? fillColor;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? trailing;
  final Widget? suffix;
  final double? radius;
  final double? hFontSize;
  final FontWeight? fontWeight;
  void Function()? onTap;

  CustomTextField({
    super.key,
    this.readOnly,
    this.hintText,
    this.maxLength,
    this.cursorHeight,
    this.minLine,
    this.enableInteractiveSelection,
    this.hintTextColor,
    this.textColor,
    this.fillColor,
    this.controller,
    this.isPassword,
    this.keyboardType,
    this.trailing, // Added trailing widget
    this.cursorColor,
    this.suffix, // Added trailing widget
    this.radius, // Added trailing widget
    this.hFontSize,
    this.fontWeight,
    this.enabled,
    this.onTap
    // Added trailing widget
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: minLine,
      maxLines: maxLine,
      // cursorHeight: cursorHeight ?? 18, // Adjust cursor height as needed
      // cursorColor: cursorColor,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly ?? false,
      obscureText: isPassword ?? false,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      enableInteractiveSelection: enableInteractiveSelection ?? true,
      enabled: enabled,
      // Center the cursor vertically
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor ??
            Colors.transparent,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // Adjust vertical padding
        hintText: hintText ?? "",
        hintStyle: TextStyle(
            color: hintTextColor ?? AppColors.greyA6AEBF,
            fontSize: hFontSize),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: BorderSide(
              color: AppColors.greyA6AEBF.withOpacity(0.5), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: BorderSide(
              color: AppColors.greyA6AEBF.withOpacity(0.5), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 12.0),
          borderSide: BorderSide(
              color: AppColors.greyA6AEBF.withOpacity(0.5), width: 1.5),
        ),
        suffixIcon: suffix ?? SizedBox.shrink(), // Added trailing widget
      ),
    );
  }
}
