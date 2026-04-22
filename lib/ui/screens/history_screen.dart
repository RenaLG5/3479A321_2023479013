import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: theme.colorScheme.primary,
      ),

      backgroundColor: theme.colorScheme.secondary,
      body: const Center(child: Text('Aquí irá la lista de partidas')),
    );
  }
}
