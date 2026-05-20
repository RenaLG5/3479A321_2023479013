import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  String _difficulty = 'Fácil';

  String get difficulty => _difficulty;

  // Propiedad calculada
  int get gridSize =>
      _difficulty == 'Fácil' ? 8 : (_difficulty == 'Medio' ? 10 : 12);

  int get bombCount =>
      _difficulty == 'Fácil' ? 10 : (_difficulty == 'Medio' ? 15 : 20);

  SettingsViewModel() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    _difficulty = prefs.getString('difficulty') ?? 'Fácil';

    notifyListeners();
  }

  Future<void> saveSettings(String difficulty) async {
    final prefs = await SharedPreferences.getInstance();

    _difficulty = difficulty;

    await prefs.setString('difficulty', difficulty);

    notifyListeners();
  }
}
