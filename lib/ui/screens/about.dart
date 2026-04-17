import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.info, size: 50, color: theme.colorScheme.primary),
              Text(
                'Buscaminas App',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Desarrollado por: Renato León',
                style: theme.textTheme.bodyMedium,
              ),

              const SizedBox(height: 60),

              Text(
                'Esta aplicación recrea el clásico juego de Buscaminas, donde el objetivo es descubrir todas las celdas sin activar una mina.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Text(
                'El jugador debe utilizar lógica y observación para identificar la ubicación de las minas, marcándolas con banderas.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Text(
                'Proyecto desarrollado en Flutter para fines educativos.',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
