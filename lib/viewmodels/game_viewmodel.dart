import 'package:flutter/material.dart';
import '../models/cell_model.dart';
import 'package:logger/logger.dart';

import 'dart:math';
import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class GameViewModel extends ChangeNotifier {
  final AudioPlayer _sfxPlayer = AudioPlayer();

  StreamSubscription? _accelerometerSubscription;

  var logger = Logger();

  List<CellModel> cells = [];

  int boardSize = 8;

  int bombCount = 10;

  bool isGameOver = false;

  bool hasWon = false;

  int totalBombs = 10;

  Timer? _timer;

  int secondsElapsed = 0;

  bool hasStarted = false;

  void _playSound(String fileName) async {
    await _sfxPlayer.release();
    await _sfxPlayer.play(AssetSource('audio/$fileName'));
  }

  void _initAccelerometer() {
    _accelerometerSubscription = accelerometerEventStream().listen((
      AccelerometerEvent event,
    ) {
      logger.i(event.x.abs());
      if (isGameOver && event.x.abs() > 15.0) {
        resetGame();
      }
    });
  }

  GameViewModel() {
    loadSettings();
    _createBoard();
    _initAccelerometer();
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

    _playSound('click.mp3');
    if (isGameOver) return;

    if (cells[index].isRevealed) return;

    if (cells[index].isBomb) {
      cells[index].isRevealed = true;

      isGameOver = true;

      _playSound('explosion.mp3');

      _revealAll();

      _timer?.cancel();

      notifyListeners();

      return;
    }

    _floodFill(index);

    _checkVictory();

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

  void _checkVictory() {
    int revealedSafeCells = cells
        .where((cell) => cell.isRevealed && !cell.isBomb)
        .length;

    int totalSafeCells = (boardSize * boardSize) - bombCount;

    if (revealedSafeCells == totalSafeCells) {
      isGameOver = true;
      hasWon = true;

      _timer?.cancel();

      _playSound('victory.mp3');

      notifyListeners();
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

    hasWon = false;

    totalBombs = bombCount;

    _createBoard();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sfxPlayer.dispose();
    super.dispose();
    _accelerometerSubscription?.cancel();
  }
}
