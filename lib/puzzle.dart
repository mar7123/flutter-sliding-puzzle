import 'package:flutter/material.dart';

class Puzzle with ChangeNotifier {
  Puzzle({this.numTile = 4}) : counter = 0 {
    // puzzleTiles = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 11, 13, 14, 0, 12];
    newGame();
  }
  int numTile;
  int counter;
  late List<int> puzzleTiles;
  late int blankPos;

  void newGame() {
    do {
      reset();
      puzzleTiles.shuffle();
    } while (!isSolvable());
    // while (!isSolvable()) {
    //   reset();
    //   puzzleTiles.shuffle();
    // }
    counter = 0;
    for (int i = 0; i < numTile * numTile; i++) {
      if (puzzleTiles[i] == 0) {
        blankPos = i;
        break;
      }
    }
    notifyListeners();
  }

  void tilePressed(BuildContext context, int pos) {
    int x = pos ~/ numTile;
    int y = pos % numTile;
    int blankX = blankPos ~/ numTile;
    int blankY = blankPos % numTile;
    notifyListeners();
    if (((x - blankX).abs() == 1 && y == blankY) ||
        ((y - blankY).abs() == 1 && x == blankX)) {
      int temp = puzzleTiles[pos];
      puzzleTiles[pos] = puzzleTiles[blankPos];
      puzzleTiles[blankPos] = temp;
      blankPos = pos;
      if (isSolved()) {
        showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Game Over"),
                content: const Text("You won"),
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        newGame();
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text("Restart"))
                ],
              );
            });
        return;
      }
      counter++;
    }
  }

  void reset() {
    puzzleTiles = List<int>.generate(
        numTile * numTile, (int index) => (index + 1) % (numTile * numTile));
    blankPos = (numTile * numTile) - 1;
  }

  bool isSolvable() {
    int countInversion = 0;
    int blank = numTile - 1;
    bool blankFound = false;
    int nbTiles = (numTile * numTile) - 1;
    for (int i = 0; i < nbTiles; i++) {
      for (int j = 0; j < i; j++) {
        if (!blankFound && puzzleTiles[j] == 0) {
          blank = j;
          blankFound = true;
        }
        if (puzzleTiles[i] > puzzleTiles[j]) {
          countInversion++;
        }
      }
    }
    if (numTile % 2 != 0 && countInversion % 2 == 0) {
      return true;
    }
    if ((numTile - (blank ~/ numTile)) % 2 == 0 && countInversion % 2 != 0) {
      return true;
    } else if ((numTile - (blank ~/ numTile)) % 2 != 0 &&
        countInversion % 2 == 0) {
      print("t");
      return true;
    }
    return false;
  }

  bool isSolved() {
    if (puzzleTiles[puzzleTiles.length - 1] != 0) {
      return false;
    }
    for (int i = (numTile * numTile) - 2; i >= 0; i--) {
      if (puzzleTiles[i] != i + 1) {
        return false;
      }
    }
    return true;
  }
}
