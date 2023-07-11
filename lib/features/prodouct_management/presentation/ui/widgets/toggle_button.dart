import 'package:flutter/material.dart';

typedef void SelectedStateCallBack(ToggleSate state);

class ColumnGridToggleButton extends StatefulWidget {
  SelectedStateCallBack selectedState;

  ColumnGridToggleButton({super.key, required this.selectedState});

  @override
  State<ColumnGridToggleButton> createState() => _ColumnGridToggleButtonState();
}

class _ColumnGridToggleButtonState extends State<ColumnGridToggleButton> {
  final _textStyle = const TextStyle(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500);
  bool isColumnSelected = true;
  bool isGridSelected = false;

  final _circularRadius = const Radius.circular(10);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isColumnSelected = true;
              isGridSelected = false;
            });
            widget.selectedState(ToggleSate.COLUMN);
          },
          child: Container(
              height: 28,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: _circularRadius, bottomLeft: _circularRadius),
                  color: isColumnSelected ? Colors.blue : Colors.grey),
              child: Center(child: Text("Column", style: _textStyle))),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isColumnSelected = false;
              isGridSelected = true;
            });
            widget.selectedState(ToggleSate.GRID);
          },
          child: Container(
              height: 28,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: _circularRadius, bottomRight: _circularRadius),
                  color: isGridSelected ? Colors.blue : Colors.grey),
              child: Center(
                child: Text(
                  "Grid",
                  style: _textStyle,
                ),
              )),
        )
      ],
    );
  }
}

enum ToggleSate { COLUMN, GRID }