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