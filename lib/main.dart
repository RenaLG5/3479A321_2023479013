import 'package:flutter/material.dart';

void main() {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
                    SizedBox(width: 10),
                    Text(
                      '349 segundos',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MineCell extends StatelessWidget {
  final int index;

  const MineCell({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        border: Border.all(color: Colors.grey[600]!, width: 1.5),
      ),
    );
  }
}
