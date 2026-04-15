import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'ui/screens/minesweeper_screen.dart';

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

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.teal,
          secondary: Colors.orange,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 200, 230, 255),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        useMaterial3: true,
      ),

      home: const MinesweeperScreen(),
    );
  }
}
