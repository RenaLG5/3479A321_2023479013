import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class MineCell extends StatelessWidget {
  final int index;

  const MineCell({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        border: Border.all(color: theme.colorScheme.outline, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Image.asset('assets/icons/land-mine.png', width: 30, height: 30),
      ),
    );
  }
}
