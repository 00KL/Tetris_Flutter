// grid dimensions
import 'dart:ui';

int rowLength = 10;
int colLength = 15;

enum Direction {
  left,
  right,
  down,
}

enum Tetromino {
  I,
  O,
  T,
  S,
  Z,
  J,
  L,
}

// Tetromino colors
Map<Tetromino, Color> tetrominoColor = {
  Tetromino.I: const Color(0xff00ffff),
  Tetromino.O: const Color(0xffffff00),
  Tetromino.T: const Color(0xff800080),
  Tetromino.S: const Color(0xff00ff00),
  Tetromino.Z: const Color(0xffff0000),
  Tetromino.J: const Color(0xff0000ff),
  Tetromino.L: const Color(0xffffa500),
};

// Tetris shapes:
    // I shape
    //  *
    //  *
    //  *
    //  *

    // O shape
    //  **
    //  **

    // T shape
    //  ***
    //   *

    // S shape
    //   **
    //  **

    // Z shape
    //  **
    //   **

    // J shape
    //  *
    //  ***
    
    // L shape
    //    *
    //  ***