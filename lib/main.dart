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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MinesweeperScreen(), //nueva pantalla
    );
  }
}
