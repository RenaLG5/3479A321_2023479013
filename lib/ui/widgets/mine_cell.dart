import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class MineCell extends StatelessWidget {
  final int index;

  const MineCell({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d('Celda: $index');
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[400],
        border: Border.all(color: Colors.grey[600]!, width: 1.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
