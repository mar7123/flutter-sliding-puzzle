import 'package:flutter/material.dart';

import 'puzzle.dart';
import 'puzzle_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sliding Puzzle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Sliding Puzzle'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Puzzle puz = Puzzle(numTile: 4);

  @override
  void initState() {
    puz.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double safeAreaHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: safeAreaHeight * 0.1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Moves: ${puz.counter}',
                    style: TextStyle(
                        fontSize: safeAreaHeight * 0.05,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return PuzzleGrid(
              parentConstraints: constraints,
              puzzleObj: puz,
            );
          }))
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              if (puz.counter != 0) {
                setState(() {
                  puz.newGame();
                });
              }
            },
            child: Container(
              height: safeAreaHeight * 0.1,
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Center(
                  child: Text(
                "Reset",
                style: TextStyle(
                    fontSize: safeAreaHeight * 0.05,
                    color: Theme.of(context).colorScheme.primary),
              )),
            ),
          ))
        ],
      ),
    );
  }
}
