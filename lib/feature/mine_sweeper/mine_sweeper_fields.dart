import 'package:flutter/material.dart';
import 'package:minesweeper/feature/mine_sweeper/mine_sweeper_view_model.dart';
import 'package:minesweeper/feature/mine_sweeper/mine_sweeper_field.dart';
import 'package:provider/provider.dart';

class MineSweeperFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MineSweeperViewModel mineSweeperViewModel = context.watch();

    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: mineSweeperViewModel.getSizeOfField(),
        ),
        itemCount: mineSweeperViewModel.getSizeOfField() *
            mineSweeperViewModel.getSizeOfField(),
        itemBuilder: (context, position) {
          return MineSweeperField(
            position: position,
          );
        });
  }
}
