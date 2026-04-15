import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

void main() {
  logger.d('Debug');
  logger.i('Iniciando Buscaminas');
  logger.w('Advertencia de prueba');
  logger.e('Error de prueba');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscaminas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MinesweeperScreen(), // Apuntamos a nuestra nueva pantalla
    );
  }
}

class MinesweeperScreen extends StatelessWidget {
  const MinesweeperScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    logger.i('Renderizando MinesweeperScreen');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: const Icon(Icons.games),
        title: const Text('Buscaminas'),
      ),
      body: SafeArea(
        // Protege la UI de los bordes del dispositivo
        child: Column(
          // Apila el marcador arriba y el tablero abajo
          children: [
            // Área de Status
            Container(
              height: 60,
              color: Colors.grey[300],
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.timer),
                    SizedBox(width: 8),
                    Text(
                      '349 seg',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(width: 20),

                    Icon(Icons.warning),
                    SizedBox(width: 8),
                    Text(
                      '10 minas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    SizedBox(width: 20),

                    Icon(Icons.grid_on),
                    SizedBox(width: 8),
                    Text(
                      '64 cuadros',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
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
          aspectRatio: 1.0, // Cuadrado perfecto
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(), // Bloquea el scroll
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8, // 8 columnas
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: 64, // 8x8 = 64 celdas
            itemBuilder: (context, index) {
              return MineCell(index: index);
            },
          ),
        ),
      ),
    );
  }
}

class MineCell extends StatelessWidget {
  final int index;

  const MineCell({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d('Celda: $index');
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        border: Border.all(color: Colors.grey[600]!, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
