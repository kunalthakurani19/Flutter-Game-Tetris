import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_game_project/piece.dart';
import 'package:tetris_game_project/pixel.dart';
import 'package:tetris_game_project/values.dart';

// this is 2D grid

//create game board

List<List<Tetromino?>> gameBoard =
    List.generate(colLength, (i) => List.generate(rowLength, (j) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // start the game
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = const Duration(milliseconds: 800);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        checkLanding();
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // check for collision detection
  // return true for collision
  // return false for no collision

  bool checkCollision(Direction direction) {
    for (var i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if piece out of bounch
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;

        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPice();
    }
    // once landed, create a new piece
  }

  void createNewPice() {
    //create a random type
    Random rand = Random();

    Tetromino randomtype =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomtype);
    currentPiece.initializePiece();
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void moveRotate() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  //get row and col of each index
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  // current piece
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.color,
                      child: index,
                    );
                  }

                  //landed pices
                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                        color: tetrominoColors[tetrominoType], child: '');
                  }

                  //blank pixels
                  else {
                    return Pixel(
                      color: Colors.grey[900],
                      child: index,
                    );
                  }
                }),
          ),
          // game controls
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back),
                ),
                //rotate
                IconButton(
                  onPressed: moveRotate,
                  color: Colors.white,
                  icon: Icon(Icons.rotate_right),
                ),
                //right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: Icon(Icons.arrow_right),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
