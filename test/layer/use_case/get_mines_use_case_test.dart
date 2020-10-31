import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/layer/use_case/get_mines_use_case.dart';
import 'dart:math';

void main() {
  GetMinesUseCase _getMinesUseCase;

  group('GetMinesUseCase', () {
    setUp(() {
      _getMinesUseCase = GetMinesUseCase();
    });

    test('should return a list with X entries', () {
      List<int> mines = _getMinesUseCase.execute(150, 20);
      expect(mines.length, 20);
    });

    test('should return a list with entries not higher than X', () {
      List<int> mines = _getMinesUseCase.execute(50, 20);
      expect(mines.reduce(max), lessThan(50));
    });
  });
}
