import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/game_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gameVM = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            ListTile(
              title: const Text('Tamaño tablero'),
              subtitle: Text('${gameVM.boardSize} x ${gameVM.boardSize}'),
            ),

            Slider(
              value: gameVM.boardSize.toDouble(),
              min: 6,
              max: 12,
              divisions: 6,

              label: gameVM.boardSize.toString(),

              onChanged: (value) {
                gameVM.boardSize = value.toInt();

                gameVM.notifyListeners();
              },
            ),

            const SizedBox(height: 20),

            ListTile(
              title: const Text('Cantidad de minas'),
              subtitle: Text('${gameVM.bombCount} minas'),
            ),

            Slider(
              value: gameVM.bombCount.toDouble(),
              min: 5,
              max: 30,
              divisions: 25,

              label: gameVM.bombCount.toString(),

              onChanged: (value) {
                gameVM.bombCount = value.toInt();

                gameVM.notifyListeners();
              },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () async {
                await gameVM.saveSettings();

                gameVM.resetGame();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Configuración guardada')),
                );
              },

              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
