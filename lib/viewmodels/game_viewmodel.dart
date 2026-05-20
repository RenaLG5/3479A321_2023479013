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

  Timer? _timer;

  int secondsElapsed = 0;

  bool hasStarted = false;

  GameViewModel() {
    loadSettings();
    _createBoard();
  }

  void _createBoard() {
    cells = List.generate(boardSize * boardSize, (i) => CellModel(index: i));

    _generateBoard();

    _calculateAdjacentBombs();

    notifyListeners();
  }

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

    if (cells[index].isBomb) {
      cells[index].isRevealed = true;

      isGameOver = true;

      _revealAll();

      _timer?.cancel();

      notifyListeners();

      return;
    }

    _floodFill(index);

    notifyListeners();
  }

  void _floodFill(int index) {
    if (cells[index].isRevealed) return;

    cells[index].isRevealed = true;

    // Si tiene bombas cerca, detener expansión
    if (cells[index].adjacentBombs > 0) return;

    int row = index ~/ boardSize;

    int col = index % boardSize;

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int newRow = row + i;

        int newCol = col + j;

        if (newRow >= 0 &&
            newRow < boardSize &&
            newCol >= 0 &&
            newCol < boardSize) {
          int neighborIndex = newRow * boardSize + newCol;

          if (!cells[neighborIndex].isBomb) {
            _floodFill(neighborIndex);
          }
        }
      }
    }
  }

  void _generateBoard() {
    final random = Random();

    int bombsPlaced = 0;

    while (bombsPlaced < bombCount) {
      int bombIndex = random.nextInt(boardSize * boardSize);

      if (!cells[bombIndex].isBomb) {
        cells[bombIndex].isBomb = true;

        bombsPlaced++;
      }
    }
  }

  void _calculateAdjacentBombs() {
    for (var cell in cells) {
      int count = 0;

      int row = cell.index ~/ boardSize;

      int col = cell.index % boardSize;

      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int newRow = row + i;

          int newCol = col + j;

          if (newRow >= 0 &&
              newRow < boardSize &&
              newCol >= 0 &&
              newCol < boardSize) {
            int neighborIndex = newRow * boardSize + newCol;

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

    totalBombs = bombCount;

    notifyListeners();
  }

  void resetGame() {
    _timer?.cancel();

    secondsElapsed = 0;

    hasStarted = false;

    isGameOver = false;

    totalBombs = bombCount;

    _createBoard();
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }
}
