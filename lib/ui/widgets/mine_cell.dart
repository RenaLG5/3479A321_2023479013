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

  Widget _buildCellContent(BuildContext context) {
    final theme = Theme.of(context);

    if (!cell.isRevealed) {
      //celda sin revelar
      return const SizedBox();
    }

    if (cell.isBomb) {
      //bomba
      return Image.asset('assets/icons/land-mine.png', width: 30, height: 30);
    }

    if (cell.adjacentBombs == 0) {
      return const SizedBox();
    }

    Color numberColor;

    switch (cell.adjacentBombs) {
      case 1:
        numberColor = Colors.blue;
        break;

      case 2:
        numberColor = Colors.green;
        break;

      case 3:
        numberColor = Colors.red;
        break;

      case 4:
        numberColor = Colors.purple;
        break;

      default:
        numberColor = Colors.black87;
    }

    return Text(
      //número de bombas adyacentes
      '${cell.adjacentBombs}',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: numberColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cell.isRevealed
              ? theme.colorScheme.secondary.withOpacity(0.3)
              : theme.colorScheme.secondary,
          border: Border.all(color: theme.colorScheme.outline, width: 1.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: _buildCellContent(context)),
      ),
    );
  }
}
