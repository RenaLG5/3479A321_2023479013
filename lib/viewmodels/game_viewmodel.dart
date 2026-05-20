import 'package:flutter/material.dart';
import '../models/cell_model.dart';
import 'dart:math';
import 'dart:async';

class GameViewModel extends ChangeNotifier {
  List<CellModel> cells = [];

  bool isGameOver = false;

  GameViewModel() {
    cells = List.generate(64, (i) => CellModel(index: i));

    _generateBoard();
    _calculateAdjacentBombs();
  }

  Timer? _timer;

  int secondsElapsed = 0;

  bool hasStarted = false;

  void revealCell(int index) {
    if (isGameOver) return;

    if (cells[index].isRevealed) return;

    cells[index].isRevealed = true;

    if (cells[index].isBomb) {
      isGameOver = true;
      _revealAll();
    }

    notifyListeners();
  }

  void _generateBoard() {
    final random = Random();

    for (int i = 0; i < 11; i++) {
      int bombIndex = random.nextInt(64);

      cells[bombIndex].isBomb = true;
    }
  }

  void _calculateAdjacentBombs() {
    for (var cell in cells) {
      int count = 0;

      int row = cell.index ~/ 8;
      int col = cell.index % 8;

      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int newRow = row + i;
          int newCol = col + j;

          if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
            int neighborIndex = newRow * 8 + newCol;

            if (cells[neighborIndex].isBomb) {
              count++;
            }
          }
        }
      }

      if (cell.isBomb) {
        count--;
      }

      cell.adjacentBombs = count;
    }
  }

  void _revealAll() {
    for (var cell in cells) {
      cell.isRevealed = true;
    }
  }

  void resetGame() {
    isGameOver = false;

    cells = List.generate(64, (i) => CellModel(index: i));

    _generateBoard();

    _calculateAdjacentBombs();

    notifyListeners();
  }
}
