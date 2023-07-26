import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  var color;
  // var child;
  Pixel({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      margin: const EdgeInsets.all(1),
      // child: Center(
      //     child: Text(
      //   child.toString(),
      //   style: TextStyle(color: Colors.white),
      // )),
    );
  }
}
