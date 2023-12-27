import 'package:flutter/material.dart';
import 'package:note_app/core/constant/enum.dart';

class NoteTile extends StatelessWidget {
  final note;
  final TileType tileType;
  final int index;
  const NoteTile({
    super.key,
    required this.note,
    required this.tileType,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: tileType == TileType.HorRect
                  ? const EdgeInsets.only(right: 100)
                  : null,
              child: Text(
                note['title'],
                maxLines: _getMaxLines(tileType),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  note['body'],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _getTxtSize(TileType tileType) {
    switch (tileType) {
      case TileType.Square:
        return 21.0;
      case TileType.VerRect:
        return 24.0;
      case TileType.HorRect:
        return 29.0;
    }
  }

  _getMaxLines(TileType tileType) {
    switch (tileType) {
      case TileType.Square:
        return 4;
      case TileType.VerRect:
        return 8;
      case TileType.HorRect:
        return 3;
    }
  }
}
