import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/game_viewmodel.dart';
import '../../viewmodels/settings_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsVM = Provider.of<SettingsViewModel>(context);

    final gameVM = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Dificultad',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: settingsVM.difficulty,

              isExpanded: true,

              items: const [
                DropdownMenuItem(value: 'Fácil', child: Text('Fácil')),

                DropdownMenuItem(value: 'Medio', child: Text('Medio')),

                DropdownMenuItem(value: 'Difícil', child: Text('Difícil')),
              ],

              onChanged: (value) async {
                await settingsVM.saveSettings(value!);

                gameVM.boardSize = settingsVM.gridSize;

                gameVM.bombCount = settingsVM.bombCount;

                gameVM.resetGame();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuración actualizada')),
                );
              },
            ),

            const SizedBox(height: 30),

            ListTile(
              title: const Text('Tamaño tablero'),

              subtitle: Text('${gameVM.boardSize} x ${gameVM.boardSize}'),
            ),

            ListTile(
              title: const Text('Cantidad de minas'),

              subtitle: Text('${gameVM.bombCount} minas'),
            ),
          ],
        ),
      ),
    );
  }
}
