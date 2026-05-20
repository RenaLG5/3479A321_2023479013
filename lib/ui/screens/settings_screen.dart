import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/game_viewmodel.dart';
import '../../viewmodels/settings_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Fácil':
        return Colors.green;
      case 'Medio':
        return Colors.orange;
      case 'Difícil':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _difficultyIcon(String difficulty) {
    switch (difficulty) {
      case 'Fácil':
        return Icons.sentiment_satisfied_alt;
      case 'Medio':
        return Icons.warning_amber_rounded;
      case 'Difícil':
        return Icons.local_fire_department;
      default:
        return Icons.games;
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);

    final gameVM = Provider.of<GameViewModel>(context);

    final difficultyColor = _difficultyColor(settingsVM.difficulty);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),

        centerTitle: true,

        elevation: 4,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título principal
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: difficultyColor.withOpacity(0.15),

                borderRadius: BorderRadius.circular(20),

                border: Border.all(color: difficultyColor, width: 2),
              ),

              child: Column(
                children: [
                  Icon(Icons.settings, size: 70, color: difficultyColor),

                  const SizedBox(height: 10),

                  const Text(
                    'Configuración del Juego',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Dificultad
            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _difficultyIcon(settingsVM.difficulty),
                        color: difficultyColor,
                        size: 28,
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'Seleccionar dificultad',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: settingsVM.difficulty,

                    decoration: InputDecoration(
                      filled: true,

                      fillColor: difficultyColor.withOpacity(0.08),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),

                        borderSide: BorderSide(
                          color: difficultyColor,
                          width: 2,
                        ),
                      ),
                    ),

                    items: const [
                      DropdownMenuItem(
                        value: 'Fácil',
                        child: Row(
                          children: [
                            Icon(
                              Icons.sentiment_satisfied_alt,
                              color: Colors.green,
                            ),

                            SizedBox(width: 10),

                            Text('Fácil'),
                          ],
                        ),
                      ),

                      DropdownMenuItem(
                        value: 'Medio',
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.orange,
                            ),

                            SizedBox(width: 10),

                            Text('Medio'),
                          ],
                        ),
                      ),

                      DropdownMenuItem(
                        value: 'Difícil',
                        child: Row(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                            ),

                            SizedBox(width: 10),

                            Text('Difícil'),
                          ],
                        ),
                      ),
                    ],

                    onChanged: (value) async {
                      await settingsVM.saveSettings(value!);

                      gameVM.boardSize = settingsVM.gridSize;

                      gameVM.bombCount = settingsVM.bombCount;

                      gameVM.resetGame();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: _difficultyColor(value),

                          content: const Text('Configuración actualizada'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Información del tablero
            Container(
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.withOpacity(0.15),

                      child: const Icon(Icons.grid_on, color: Colors.blue),
                    ),

                    title: const Text('Tamaño del tablero'),

                    subtitle: Text('${gameVM.boardSize} x ${gameVM.boardSize}'),
                  ),

                  const Divider(),

                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.withOpacity(0.15),

                      child: Image.asset(
                        'assets/icons/land-mine.png',
                        width: 22,
                        height: 22,
                      ),
                    ),

                    title: const Text('Cantidad de minas'),

                    subtitle: Text('${gameVM.bombCount} minas'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
