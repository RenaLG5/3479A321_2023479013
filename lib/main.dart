import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'ui/screens/minesweeper_screen.dart';
import 'ui/screens/menu_screen.dart';
import 'ui/screens/history_screen.dart';
import 'ui/screens/about.dart';

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
          seedColor: Colors.green,
          primary: Colors.blue,
          secondary: Colors.grey,
        ),
        useMaterial3: true,
      ),

      initialRoute: '/menu',

      routes: {
        '/menu': (context) => const MenuScreen(),
        '/game': (context) => const MinesweeperScreen(),
        '/history': (context) => const HistoryScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
