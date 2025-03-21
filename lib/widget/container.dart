import 'package:flutter/material.dart';
import 'package:imagine/helper/helper.dart';

class ContainerWidget extends StatefulWidget {
  double? height;
  double? width;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  AlignmentGeometry? alignment;
  BorderRadiusGeometry? borderRadius;
  BoxBorder? border;
  List<BoxShadow>? boxShadow;
  BoxShape shape;
  DecorationImage? image;
  Widget? child;

  ContainerWidget({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.alignment,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.shape = BoxShape.rectangle,
    this.image,
    this.child,
  });

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      margin: widget.margin,
      alignment: widget.alignment,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: widget.borderRadius,
        border: Border.all(color: Colors.black12),
        boxShadow: themeMode == false ? widget.boxShadow : null,
        gradient: gradient,
        shape: widget.shape,
        image: widget.image,
      ),
      child: widget.child,
    );
  }
}
