import 'package:minesweeper/layer/model/mine_sweeper_fields_model.dart';

class CountMinesNextUseCase {
  MineSweeperFieldsModel execute({MineSweeperFieldsModel mineSweeperField}) {
    for (int i = 0; i < mineSweeperField.sizeOfField.getCrossAxisCount(); i++) {
      for (int j = 0;
          j < mineSweeperField.sizeOfField.getCrossAxisCount();
          j++) {
        if (i > 0 && j > 0) {
          if (mineSweeperField.field[i - 1][j - 1].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (i > 0) {
          if (mineSweeperField.field[i - 1][j].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (i > 0 && j < mineSweeperField.sizeOfField.getCrossAxisCount() - 1) {
          if (mineSweeperField.field[i - 1][j + 1].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (j > 0) {
          if (mineSweeperField.field[i][j - 1].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (j < mineSweeperField.sizeOfField.getCrossAxisCount() - 1) {
          if (mineSweeperField.field[i][j + 1].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (i < mineSweeperField.sizeOfField.getCrossAxisCount() - 1 && j > 0) {
          if (mineSweeperField.field[i + 1][j - 1].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (i < mineSweeperField.sizeOfField.getCrossAxisCount() - 1) {
          if (mineSweeperField.field[i + 1][j].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }

        if (i < mineSweeperField.sizeOfField.getCrossAxisCount() - 1 &&
            j < mineSweeperField.sizeOfField.getCrossAxisCount() - 1) {
          if (mineSweeperField.field[i + 1][j + 1].hasMine) {
            mineSweeperField.field[i][j].minesNext++;
          }
        }
      }
    }
    return mineSweeperField;
  }
}
