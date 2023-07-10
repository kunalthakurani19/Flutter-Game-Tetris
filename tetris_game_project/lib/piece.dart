import 'package:flutter/material.dart';
import 'package:tetris_game_project/values.dart';

class Piece {
  // type of tetris pices
  Tetromino type;

  Piece({required this.type});

  // the piece is just a list of intergers
  List<int> position = [];

  // color of tetris piece
  Color get color {
    return tetrominoColors[type] ?? Colors.white;
  }

  //generate the intergers
  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
      case Tetromino.Z:
        position = [
          -16,
          -17,
          -6,
          -5,
        ];
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }
}
