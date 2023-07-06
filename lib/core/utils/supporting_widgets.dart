import 'package:flutter/material.dart';

///To implement gap horizontally
Widget HorizontalGap(double gap){
  return SizedBox(
    height: 0,
    width: gap,
  );
}

///To implement gap vertically
Widget VerticalGap(double gap){
  return SizedBox(
    height: gap,
    width: 0,
  );
}

///To draw line vertically
Widget VerticalLine({
  required double lineWidth,
  required double length,
  Color color = Colors.deepOrange}){
  return ColoredBox(
    color: color,
    child: SizedBox(
      height: length,
      width: lineWidth,
    ),
  );
}

///To draw line vertically
Widget HorizontalLine({
  required double lineWidth,
  required double length,
  Color color = Colors.deepOrange}){
  return ColoredBox(
    color: color,
    child: SizedBox(
      height: lineWidth,
      width: length,
    ),
  );
}