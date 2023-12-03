import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'values.dart';

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  void initialStete() {
    position = [0, 1, 2, 3];
  }

  Color get color {
    return tetrominoColor[type] ?? Colors.white;
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
    }
  }

  // move piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (var i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (var i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (var i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
    }
  }

  // rotate piece
  int rotationState = 1;
  void rotatePiece(List<List<Tetromino?>> gameBoard) {
    // new position
    List<int> newPosition = [];

    // rotate the piece based on its type
    switch (type) {
      case Tetromino.L:
        rotatePieceL(gameBoard, newPosition);
        break;
      case Tetromino.I:
        rotatePieceI(gameBoard, newPosition);
        break;
      case Tetromino.O:
        break;
      case Tetromino.T:
        rotatePieceT(gameBoard, newPosition);
        break;
      case Tetromino.S:
        rotatePieceS(gameBoard, newPosition);
        break;
      case Tetromino.Z:
        rotatePieceZ(gameBoard, newPosition);
        break;
      case Tetromino.J:
        rotatePieceJ(gameBoard, newPosition);
        break;

      default:
    }
  }

  // L piece rotation
  void rotatePieceL(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    switch (rotationState) {
      case 0:
        // get new position
        newPosition = [
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength + 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 1:
        newPosition = [
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 2:
        newPosition = [
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - rowLength - 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 3:
        newPosition = [
          position[1] - rowLength + 1,
          position[1],
          position[1] + 1,
          position[1] - 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
    }
  }

  // I piece rotation
  void rotatePieceI(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    switch (rotationState) {
      case 0:
        // get new position
        newPosition = [
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + 2
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 2;
        }
        break;
      case 1:
        newPosition = [
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + 2 * rowLength
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 2;
        }
        break;
      case 2:
        newPosition = [
          position[1] + 1,
          position[1],
          position[1] - 1,
          position[1] - 2
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
        break;
      case 3:
        newPosition = [
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - 2 * rowLength
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
        break;
    }
  }

  // O piece rotation
  void rotatePieceO(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    // do nothing
  }

  // T piece rotation
  void rotatePieceT(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    switch (rotationState) {
      case 0:
        // get new position
        newPosition = [
          position[2] - rowLength,
          position[2],
          position[2] + 1,
          position[2] + rowLength,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 1:
        newPosition = [
          position[1] - 1,
          position[1],
          position[1] + 1,
          position[1] + rowLength
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 2:
        newPosition = [
          position[1] - rowLength,
          position[1] - 1,
          position[1],
          position[1] + rowLength,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 3:
        newPosition = [
          position[2] - rowLength,
          position[2] - 1,
          position[2],
          position[2] + 1,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
        break;
    }
  }

  // S piece rotation
  void rotatePieceS(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    switch (rotationState) {
      case 0:
        // get new position
        newPosition = [
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
          position[1] + rowLength,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 2;
        }
        break;

      case 1:
        newPosition = [
          position[0] - rowLength,
          position[0],
          position[0] + 1,
          position[0] + rowLength + 1,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 2;
        }
        break;

      case 2:
        newPosition = [
          position[1],
          position[1] + 1,
          position[1] + rowLength - 1,
          position[1] + rowLength,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 2;
        }
        break;

      case 3:
        newPosition = [
          position[0] - rowLength,
          position[0],
          position[0] + 1,
          position[0] + rowLength + 1,
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
    }
  }

  // J piece rotation
  void rotatePieceJ(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    switch (rotationState) {
      case 0:
        // get new position
        newPosition = [
          position[1] - rowLength,
          position[1],
          position[1] + rowLength,
          position[1] + rowLength - 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 1:
        newPosition = [
          position[1] - rowLength - 1,
          position[1],
          position[1] - 1,
          position[1] + 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 2:
        newPosition = [
          position[1] + rowLength,
          position[1],
          position[1] - rowLength,
          position[1] - rowLength + 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = (rotationState + 1) % 4;
        }
        break;
      case 3:
        newPosition = [
          position[1] + 1,
          position[1],
          position[1] - 1,
          position[1] + rowLength + 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
        break;
    }
  }

  // Z piece rotation
  void rotatePieceZ(List<List<Tetromino?>> gameBoard, List<int> newPosition) {
    switch (rotationState) {
      case 0:
        // get new position
        newPosition = [
          position[0] + rowLength - 2,
          position[1],
          position[2] + rowLength - 1,
          position[3] + 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 1;
        }
        break;
      case 1:
        newPosition = [
          position[0] - rowLength + 2,
          position[1],
          position[2] - rowLength + 1,
          position[3] - 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
        break;
      case 2:
        newPosition = [
          position[0] + rowLength - 2,
          position[1],
          position[2] + rowLength - 1,
          position[3] + 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 1;
        }
        break;
      case 3:
        newPosition = [
          position[0] - rowLength + 2,
          position[1],
          position[2] - rowLength + 1,
          position[3] - 1
        ];
        // update position
        if (piecePositionIdValid(newPosition, gameBoard)) {
          position = newPosition;
          rotationState = 0;
        }
        break;
    }
  }

  // check if valid position
  bool positionIsValid(int positon, List<List<Tetromino?>> gameBoard) {
    // get the row and col of position
    int row = (positon / rowLength).floor();
    int col = (positon % rowLength);

    // if the position is taken, return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }

    // if the position is valid, return true
    return true;
  }

  // check if piece is valid position
  bool piecePositionIdValid(
      List<int> piecePosition, List<List<Tetromino?>> gameBoard) {
    bool firstColOccupied = false;
    bool secondColOccupied = false;

    for (int pos in piecePosition) {
      // return false if anu position is already taken
      if (!positionIsValid(pos, gameBoard)) {
        return false;
      }

      // get the col of position
      int col = (pos % rowLength);

      // check if the first or last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        secondColOccupied = true;
      }
    }

    // if the first and last column are occupied, return false
    if (firstColOccupied && secondColOccupied) {
      return false;
    }
    return true;
  }
}
