import 'package:flutter/material.dart';

enum Tetromino { L, J, I, O, S, Z, T }

int rowLength = 10;
int colLength = 15;

enum Direction { left, right, down }

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500), // Orange
  Tetromino.J: Color.fromARGB(255, 0, 102, 255), // Blue
  Tetromino.I: Color.fromARGB(255, 242, 0, 255), // Pink
  Tetromino.O: Color(0xFFFFFF00), // Yellow
  Tetromino.S: Color(0xFF008000), // Green
  Tetromino.Z: Color(0xFFFF0000), // Red
  Tetromino.T: Color.fromARGB(255, 144, 0, 255), // Purple
};
