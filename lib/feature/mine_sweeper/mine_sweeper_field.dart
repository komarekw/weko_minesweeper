import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:minesweeper/feature/mine_sweeper/mine_sweeper_view_model.dart';
import 'package:provider/provider.dart';

class MineSweeperField extends StatelessWidget {
  final int position;

  const MineSweeperField({Key key, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MineSweeperViewModel mineSweeperViewModel = context.watch();

    final row = (position / 10).floor();
    final column = (position % mineSweeperViewModel.getSizeOfField());
    return InkWell(
      onLongPress: () {
        if (!mineSweeperViewModel.lose &&
            !mineSweeperViewModel.mineSweeperFields.field[row][column].isOpen) {
          mineSweeperViewModel.onLongClick(row, column);
        }
      },
      onTap: () {
        if (!mineSweeperViewModel.lose &&
            !mineSweeperViewModel
                .mineSweeperFields.field[row][column].hasFlag) {
          if (mineSweeperViewModel
              .mineSweeperFields.field[row][column].hasMine) {
            mineSweeperViewModel.onLose();
          } else {
            mineSweeperViewModel.onClick(row, column);
          }
        }
      },
      child: Card(
        margin: EdgeInsets.all(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: mineSweeperViewModel.mineSweeperFields.field[row][column].isOpen
            ? Colors.white
            : Colors.grey,
        child: getCardChild(row, column, mineSweeperViewModel),
      ),
    );
  }

  Widget getCardChild(
      int row, int column, MineSweeperViewModel mineSweeperViewModel) {
    if (mineSweeperViewModel.lose || mineSweeperViewModel.gameEnd) {
      if (mineSweeperViewModel.mineSweeperFields.field[row][column].hasMine) {
        if (mineSweeperViewModel.mineSweeperFields.field[row][column].hasFlag) {
          return Icon(
            MaterialCommunityIcons.bomb_off,
            color: Colors.black,
          );
        } else {
          return Icon(
            MaterialCommunityIcons.bomb,
            color: Colors.black,
          );
        }
      }
    }

    if (mineSweeperViewModel.mineSweeperFields.field[row][column].isOpen &&
        mineSweeperViewModel.mineSweeperFields.field[row][column].minesNext > 0)
      return Text(
        '${mineSweeperViewModel.mineSweeperFields.field[row][column].minesNext}',
        textAlign: TextAlign.center,
      );

    if (mineSweeperViewModel.mineSweeperFields.field[row][column].hasFlag &&
        !mineSweeperViewModel.lose &&
        !mineSweeperViewModel.mineSweeperFields.field[row][column].isOpen) {
      return Icon(
        Icons.flag,
        color: Colors.red,
      );
    }

    return Container();
  }
}
