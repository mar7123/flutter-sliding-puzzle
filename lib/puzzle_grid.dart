import 'package:flutter/material.dart';
import 'package:puzzle15/puzzle.dart';

class PuzzleGrid extends StatelessWidget {
  const PuzzleGrid({
    super.key,
    required this.parentConstraints,
    required this.puzzleObj,
  });
  final BoxConstraints parentConstraints;
  final Puzzle puzzleObj;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: parentConstraints.maxWidth / puzzleObj.numTile,
          mainAxisExtent: parentConstraints.maxHeight / puzzleObj.numTile),
      itemCount: puzzleObj.numTile * puzzleObj.numTile,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            puzzleObj.tilePressed(context, index);
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              color: puzzleObj.puzzleTiles[index] != 0
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              child: Center(
                  child: puzzleObj.puzzleTiles[index] != 0
                      ? Text(
                          "${puzzleObj.puzzleTiles[index]}",
                          style: TextStyle(
                              fontSize: parentConstraints.maxHeight *
                                  0.3 /
                                  puzzleObj.numTile,
                              color: Colors.white),
                        )
                      : const Text("")),
            ),
          ),
        );
      },
    );
  }
}
