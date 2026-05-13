import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '/models/cell_model.dart';

var logger = Logger();

class MineCell extends StatelessWidget {
  final int index;
  final CellModel cell;
  final VoidCallback onTap;

  const MineCell({
    Key? key,
    required this.index,
    required this.cell,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          border: Border.all(color: theme.colorScheme.outline, width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: cell.isRevealed
              ? cell.isBomb
                    ? Image.asset(
                        'assets/icons/land-mine.png',
                        width: 30,
                        height: 30,
                      )
                    : Text(
                        '0',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSecondary,
                        ),
                      )
              : null,
        ),
      ),
    );
  }
}
