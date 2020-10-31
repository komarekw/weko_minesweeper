import 'package:flutter/material.dart';
import 'package:minesweeper/locator/locator.dart';
import 'package:minesweeper/feature/mine_sweeper/mine_sweeper.dart';

void main() {
  initSyncDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MineSweeper(),
      routes: {
        MineSweeper.routeName: (ctx) => MineSweeper(),
      },
    );
  }
}
