
import 'package:flutter/material.dart';

import '../style/color.dart';

class Component extends Container {
  Component(
      {Key? key,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.borderRadius,
      required this.child})
      : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 249, 246, 246),
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            ),
        child: child);
  }
}


class ComponentFor extends Container {
  ComponentFor(
      {Key? key,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.borderRadius,
      required this.child})
      : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: borderRadius ?? BorderRadius.circular(30),
            ),
        child: child);
  }
}

class ComponentForIcons extends Container {
  ComponentForIcons(
      {Key? key,
      this.width,
      this.height,
      this.padding,
      this.margin,
      this.borderRadius,
      required this.child})
      : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: borderRadius ?? BorderRadius.circular(50),
            ),
        child: child);
  }
}