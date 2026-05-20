import 'package:flutter/material.dart';
import '../models/cell_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';

class GameViewModel extends ChangeNotifier {
  List<CellModel> cells = [];

  int boardSize = 8;

  int bombCount = 10;

  bool isGameOver = false;

  int totalBombs = 10;

  GameViewModel() {
    cells = List.generate(64, (i) => CellModel(index: i));

    _generateBoard();
    _calculateAdjacentBombs();
  }

  Timer? _timer;

  int secondsElapsed = 0;

  bool hasStarted = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsElapsed++;

      notifyListeners();
    });
  }

  void revealCell(int index) {
    if (!hasStarted) {
      hasStarted = true;
      _startTimer();
    }
    if (isGameOver) return;

    if (cells[index].isRevealed) return;

    cells[index].isRevealed = true;

    if (cells[index].isBomb) {
      isGameOver = true;
      _revealAll();
      _timer?.cancel();
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

  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('boardSize', boardSize);

    await prefs.setInt('bombCount', bombCount);
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    boardSize = prefs.getInt('boardSize') ?? 8;

    bombCount = prefs.getInt('bombCount') ?? 10;

    notifyListeners();
  }

  void resetGame() {
    _timer?.cancel();

    secondsElapsed = 0;

    hasStarted = false;

    isGameOver = false;

    cells = List.generate(64, (i) => CellModel(index: i));

    _generateBoard();

    _calculateAdjacentBombs();

    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
