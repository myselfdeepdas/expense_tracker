import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Color(0xFF3A69F9),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
                        Icons.add_circle_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
          // child: Text(
          //   '+',
          //   style: TextStyle(color: Colors.white, fontSize: 25),
          // ),
        ),
      ),
    );
  }
}