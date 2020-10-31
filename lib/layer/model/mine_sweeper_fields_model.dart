import 'package:minesweeper/layer/model/mine_sweeper_field_model.dart';

enum SizeOfField { small, middle, big }

extension GetNumber on SizeOfField {
  int getCrossAxisCount() {
    switch (this) {
      case SizeOfField.small:
        return 10;
        break;
      case SizeOfField.middle:
        return 15;
        break;
      case SizeOfField.big:
        return 20;
        break;
      default:
        return 0;
    }
  }
}

class MineSweeperFieldsModel {
  List<List<MineSweeperFieldModel>> field;
  SizeOfField sizeOfField;
  int numberOfMines;
}
