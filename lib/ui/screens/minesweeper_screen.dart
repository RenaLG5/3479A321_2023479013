import 'package:flutter/material.dart';
import '../widgets/mine_cell.dart';
import 'package:logger/logger.dart';
import 'about.dart';

var logger = Logger();

class MinesweeperScreen extends StatelessWidget {
  const MinesweeperScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.i('Renderizando MinesweeperScreen');

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
                    Text('349 seg', style: theme.textTheme.bodyMedium),

                    const SizedBox(width: 20),

                    Image.asset('assets/icons/flag.png', width: 30, height: 30),
                    const SizedBox(width: 5),
                    Text('10 minas', style: theme.textTheme.bodyMedium),

                    const SizedBox(width: 20),

                    Icon(
                      Icons.grid_on,
                      size: 30,
                      color: theme.colorScheme.onSecondary,
                    ),
                    const SizedBox(width: 5),
                    Text('64 cuadros', style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ),

            Divider(height: 1, color: theme.colorScheme.outline),

            // Área de Juego
            Expanded(child: _gameBoard()),
          ],
        ),
      ),
    );
  }

  Widget _gameBoard() {
    logger.d('Construyendo tablero');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: 64,
            itemBuilder: (context, index) {
              return MineCell(index: index);
            },
          ),
        ),
      ),
    );
  }
}
