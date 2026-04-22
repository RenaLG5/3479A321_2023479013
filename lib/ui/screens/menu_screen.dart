import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
        backgroundColor: theme.colorScheme.primary,
      ),

      backgroundColor: theme.colorScheme.secondary,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.extension, size: 80, color: theme.colorScheme.primary),

            const SizedBox(height: 20),

            Text(
              'Buscaminas',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/game'),
              child: const Text('Jugar'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/history'),
              child: const Text('Historial'),
            ),
          ],
        ),
      ),
    );
  }
}
