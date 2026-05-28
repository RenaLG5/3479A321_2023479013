import 'package:flutter/material.dart';
import '../widgets/mine_cell.dart';
import '/models/cell_model.dart';

import 'package:provider/provider.dart';
import '/viewmodels/game_viewmodel.dart';

import 'package:logger/logger.dart';
import 'about.dart';

var logger = Logger();

class MinesweeperScreen extends StatelessWidget {
  const MinesweeperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.i('Renderizando MinesweeperScreen');

    final gameVM = Provider.of<GameViewModel>(context);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        leading: const Icon(Icons.games),
        title: const Text('Buscaminas'),

        actions: [
          IconButton(
            icon: Icon(
              Icons.person_outline,
              size: 40,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutScreen()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings, size: 35, color: Colors.black),

            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Área de Status
            Container(
              height: 60,
              color: theme.colorScheme.secondary,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 30,
                      color: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${gameVM.secondsElapsed} seg',
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(width: 20),

                    Image.asset('assets/icons/flag.png', width: 30, height: 30),
                    const SizedBox(width: 5),
                    Text(
                      '${gameVM.bombCount} minas',
                      style: theme.textTheme.bodyMedium,
                    ),

                    const SizedBox(width: 20),

                    Icon(
                      Icons.grid_on,
                      size: 30,
                      color: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${gameVM.boardSize * gameVM.boardSize} cuadros',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),

            Divider(height: 1, color: theme.colorScheme.outline),
            if (gameVM.isGameOver)
              Container(
                width: double.infinity,
                color: gameVM.hasWon ? Colors.green : Colors.red,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      gameVM.hasWon ? '¡VICTORIA!' : 'GAME OVER',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            // Área de Juego
            Expanded(child: _gameBoard(gameVM)),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                gameVM.resetGame();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Reiniciar partida'),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _gameBoard(GameViewModel gameVM) {
    logger.d('Construyendo tablero');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gameVM.boardSize,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: gameVM.cells.length,
            itemBuilder: (context, index) {
              return MineCell(
                index: index,
                cell: gameVM.cells[index],
                onTap: () => gameVM.revealCell(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
