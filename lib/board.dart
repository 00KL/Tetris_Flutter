import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris_flutter/piece.dart';
import 'package:tetris_flutter/pixel.dart';
import 'package:tetris_flutter/values.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

// create game board
List<List<Tetromino?>> gameBoard = List.generate(
    colLength,
    (i) => List.generate(
          rowLength,
          (j) => null,
        ));

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  late Piece currentPiece;

  int currentsScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();

    // start game when app starts
    startGame();
  }

  void startGame() {
    // initalize with a random piece
    currentPiece = Piece(type: getRandomType());
    currentPiece.initializePiece();

    // frame rafresh rate
    const frameRate = Duration(milliseconds: 300);
    gameLoop(frameRate);
  }

  // game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear lines
        clearLines();

        // check if piece has landed
        checkLanding();

        // check if game is over
        if (gameOver) {
          timer.cancel();
          // show game over dialog
          showGameOverDialog();
        }

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // game over messsage
  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Your score: $currentsScore'),
            actions: [
              TextButton(
                  onPressed: () {
                    // reset game
                    resetGame();
                    // close dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'))
            ],
          );
        });
  }

  // reset game
  void resetGame() {
    // reset game board
    gameBoard = List.generate(
        colLength,
        (i) => List.generate(
              rowLength,
              (j) => null,
            ));

    // reset score
    currentsScore = 0;

    // reset game over
    gameOver = false;

    // start game
    startGame();
  }

  // move piece left
  void moveLeft() {
    if (!checkColision(Direction.left)) {
      setState(() {
        // move piece left
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move piece right
  void moveRight() {
    if (!checkColision(Direction.right)) {
      setState(() {
        // move piece right
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // rotate piece
  void rotatePiece() {
    setState(() {
      // rotate piece
      currentPiece.rotatePiece(gameBoard);
    });
  }

  // check for colision  ina future position
  // return true -> there is a colision
  // return false -> there is no colision
  bool checkColision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      // calculate the roe and col of the current position
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      // adjustment the roe and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if piece is out of bounds
      if (row >= colLength || col >= rowLength || col < 0) {
        return true;
      }

      if (row >= 0 && col >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }

    // if no colision are detected, return false
    return false;
  }

  void checkLanding() {
    // if goind down is occupied
    if (checkColision(Direction.down)) {
      // mark piece as occupied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      // create new piece
      createNewPiece();
    }
  }

  Tetromino getRandomType() {
    // create ramdom piece
    Random rand = Random();

    // create a new piece with random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];

    return randomType;
  }

  void createNewPiece() {
    currentPiece.type = getRandomType();
    // currentPiece = Piece(type: Tetromino.I);
    currentPiece.initializePiece();

    /**
     * 
     * Since  our gam over condition is if there is a piece at the top level,
     * you want to check if the game is over when tou create a new piece
     * instead of checking every grame, beacoise new piece are allowed to 
     * got through the top level but if there is already a piece in the top level
     * when the new piece is created, the game is over
     */

    if (isGameOver()) {
      // stop game loop
      gameOver = true;
      // show game over dialog
      // showGameOverDialog();
    }
  }

  // GAME OVER METHOD
  bool isGameOver() {
    // check if anu columns in the top row are filled
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if no columns in the top row are filled, return false
    return false;
  }

  // clear lines
  void clearLines() {
    // step1: Loop through each row of the game board from buttom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // step2: initialize a bool variable to check if the current row is full
      bool rowIsFull = true;
      // step3: Check if the row is full (all columns in the roware filled with pieces)
      for (int col = 0; col < rowLength; col++) {
        // if there is an empty space in the row, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step4: if the row is full, clear the row and sshift rows down
      if (rowIsFull) {
        // step5: move all row above the clieared row down by one position
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step6: set the top row to empty
        gameBoard[0] = List.generate(rowLength, (i) => null);

        // step7: increment score
        currentsScore += 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            // game board
            Expanded(
              child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  // get row and col of each index
                  int row = (index / rowLength).floor();
                  int col = (index % rowLength);

                  // current piece position
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: Colors.yellow,
                      child: '',
                    );
                  }
                  // landed pieces
                  else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                      color: tetrominoColor[tetrominoType],
                      child: '',
                    );
                  }
                  // blak pixel
                  else {
                    return Pixel(
                      color: Colors.grey[900],
                      child: index,
                    );
                  }
                },
              ),
            ),

            // SCORE
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Score: $currentsScore',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),

            // GAME CONTROLS
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // left
                  IconButton(
                      onPressed: moveLeft,
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back_ios)),

                  // rotate
                  IconButton(
                      onPressed: rotatePiece,
                      color: Colors.white,
                      icon: Icon(Icons.rotate_right)),

                  // right
                  IconButton(
                      onPressed: moveRight,
                      color: Colors.white,
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            )
          ],
        ));
  }
}
