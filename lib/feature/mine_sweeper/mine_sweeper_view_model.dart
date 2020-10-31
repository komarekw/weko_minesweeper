import 'package:flutter/foundation.dart';
import 'package:minesweeper/layer/model/mine_sweeper_field_model.dart';
import 'package:minesweeper/layer/model/mine_sweeper_fields_model.dart';
import 'package:minesweeper/layer/use_case/count_mines_next_use_case.dart';
import 'package:minesweeper/layer/use_case/get_mines_use_case.dart';
import 'package:minesweeper/locator/locator.dart';

enum ViewState {
  idle,
  busy,
  error,
}

class MineSweeperViewModel extends ChangeNotifier {
  GetMinesUseCase _getMinesUseCase = locator.get();
  CountMinesNextUseCase _countMinesNextUseCase = locator.get();

  MineSweeperFieldsModel mineSweeperFields;
  int completeCount = 0;
  ViewState viewState = ViewState.idle;
  int numberOfMines = 10;
  bool gameEnd = false;
  bool lose = false;

  MineSweeperViewModel(SizeOfField sizeOfField) {
    setViewState(ViewState.busy);
    mineSweeperFields = MineSweeperFieldsModel();
    completeCount =
        sizeOfField.getCrossAxisCount() * sizeOfField.getCrossAxisCount();
    List<int> mines = _getMinesUseCase.execute(completeCount, numberOfMines);
    int actualMineCount = 0;
    List<List<MineSweeperFieldModel>> list =
        List.generate(sizeOfField.getCrossAxisCount(), (indexA) {
      return List.generate(sizeOfField.getCrossAxisCount(), (indexB) {
        MineSweeperFieldModel newField = MineSweeperFieldModel();
        newField.hasMine = mines.contains(actualMineCount);
        actualMineCount++;
        print('actualCount: $actualMineCount');
        print('gotMine: ${newField.hasMine}');
        return newField;
      });
    });
    mineSweeperFields.numberOfMines = numberOfMines;
    mineSweeperFields.field = list;
    mineSweeperFields.sizeOfField = sizeOfField;
    mineSweeperFields =
        _countMinesNextUseCase.execute(mineSweeperField: mineSweeperFields);
    _countMines();
    print(mines);
    setViewState(ViewState.idle);
  }

  void setViewState(ViewState _viewState) {
    viewState = _viewState;
    notifyListeners();
  }

  int getSizeOfField() {
    return mineSweeperFields.sizeOfField.getCrossAxisCount();
  }

  void onClick(int row, int column) {
    setViewState(ViewState.busy);
    _openMine(row, column);
    gameEnd = _checkClosedFieldsLeft() == numberOfMines ||
        _checkFlaggedMines() == numberOfMines;
    setViewState(ViewState.idle);
  }

  void onLongClick(int row, int column) {
    setViewState(ViewState.busy);
    _setFlag(row, column);
    gameEnd = _checkFlaggedMines() == numberOfMines;
    setViewState(ViewState.idle);
  }

  void onLose() {
    setViewState(ViewState.busy);
    lose = true;
    setViewState(ViewState.idle);
  }

  void _setFlag(int row, int column) {
    mineSweeperFields.field[row][column].hasFlag =
        !mineSweeperFields.field[row][column].hasFlag;
  }

  void _openMine(int row, int column) {
    if (mineSweeperFields.field[row][column].hasFlag) {
      _setFlag(row, column);
    }
    mineSweeperFields.field[row][column].isOpen = true;

    if (row > 0) {
      if (!mineSweeperFields.field[row - 1][column].hasMine &&
          !mineSweeperFields.field[row - 1][column].isOpen) {
        if (mineSweeperFields.field[row - 1][column].minesNext == 0) {
          _openMine(row - 1, column);
        } else {
          mineSweeperFields.field[row - 1][column].isOpen = true;
        }
      }
    }
    if (column > 0) {
      if (!mineSweeperFields.field[row][column - 1].hasMine &&
          !mineSweeperFields.field[row][column - 1].isOpen) {
        if (mineSweeperFields.field[row][column - 1].minesNext == 0) {
          _openMine(row, column - 1);
        } else {
          mineSweeperFields.field[row][column - 1].isOpen = true;
        }
      }
    }
    if (column < mineSweeperFields.sizeOfField.getCrossAxisCount() - 1) {
      if (!mineSweeperFields.field[row][column + 1].hasMine &&
          !mineSweeperFields.field[row][column + 1].isOpen) {
        if (mineSweeperFields.field[row][column + 1].minesNext == 0) {
          _openMine(row, column + 1);
        } else {
          mineSweeperFields.field[row][column + 1].isOpen = true;
        }
      }
    }
    if (row < mineSweeperFields.sizeOfField.getCrossAxisCount() - 1) {
      if (!mineSweeperFields.field[row + 1][column].hasMine &&
          !mineSweeperFields.field[row + 1][column].isOpen) {
        if (mineSweeperFields.field[row + 1][column].minesNext == 0) {
          _openMine(row + 1, column);
        } else {
          mineSweeperFields.field[row + 1][column].isOpen = true;
        }
      }
    }
  }

  int _checkClosedFieldsLeft() {
    int count = 0;
    mineSweeperFields.field.forEach((row) {
      row.forEach((field) {
        if (!field.isOpen) {
          count++;
        }
      });
    });
    return count;
  }

  void _countMines() {
    int hasMineCount = 0;
    mineSweeperFields.field.forEach((row) {
      row.forEach((field) {
        if (field.hasMine) {
          hasMineCount++;
        }
      });
    });
    print('mines: $hasMineCount');
  }

  int _checkFlaggedMines() {
    int count = 0;
    mineSweeperFields.field.forEach((row) {
      row.forEach((field) {
        if (field.hasFlag && field.hasMine) {
          count++;
        }
      });
    });
    print('flagged mines: $count');
    return count;
  }
}
