import 'package:flutter/material.dart';
import '../../models/game_result.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final List<GameResult> listMaqueta = [
    GameResult(
      date: '30 Mar',
      timeSpent: '03:51',
      isVictory: false,
      difficulty: 'Fácil',
    ),
    GameResult(
      date: '30 Mar',
      timeSpent: '05:03',
      isVictory: false,
      difficulty: 'Fácil',
    ),
    GameResult(
      date: '31 Mar',
      timeSpent: '02:20',
      isVictory: true,
      difficulty: 'Medio',
    ),
    GameResult(
      date: '31 Mar',
      timeSpent: '04:01',
      isVictory: false,
      difficulty: 'Difícil',
    ),
    GameResult(
      date: '02 Abr',
      timeSpent: '01:34',
      isVictory: true,
      difficulty: 'Fácil',
    ),
    GameResult(
      date: '03 Abr',
      timeSpent: '03:46',
      isVictory: true,
      difficulty: 'Medio',
    ),
    GameResult(
      date: '05 Abr',
      timeSpent: '02:49',
      isVictory: true,
      difficulty: 'Fácil',
    ),
    GameResult(
      date: '05 Abr',
      timeSpent: '05:11',
      isVictory: false,
      difficulty: 'Difícil',
    ),
    GameResult(
      date: '08 Abr',
      timeSpent: '01:57',
      isVictory: true,
      difficulty: 'Medio',
    ),
    GameResult(
      date: '08 Abr',
      timeSpent: '03:32',
      isVictory: true,
      difficulty: 'Fácil',
    ),
    GameResult(
      date: '09 Abr',
      timeSpent: '02:18',
      isVictory: false,
      difficulty: 'Medio',
    ),
    GameResult(
      date: '09 Abr',
      timeSpent: '04:41',
      isVictory: false,
      difficulty: 'Difícil',
    ),
    GameResult(
      date: '10 Abr',
      timeSpent: '01:25',
      isVictory: true,
      difficulty: 'Fácil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: theme.colorScheme.primary,
      ),

      backgroundColor: theme.colorScheme.secondary,
      body: ListView.builder(
        itemCount: listMaqueta.length,
        itemBuilder: (context, index) {
          final game = listMaqueta[index];

          return Card(
            color: game.isVictory
                ? Colors.green[200] //Victoria
                : Colors.red[200], //derrota
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                game.date,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tiempo: ${game.timeSpent}'),
                  Text('Dificultad: ${game.difficulty}'),
                ],
              ),
              trailing: Icon(
                game.isVictory ? Icons.check : Icons.close,
                color: game.isVictory ? Colors.green : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
