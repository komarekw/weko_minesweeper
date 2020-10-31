import 'dart:math';

class GetMinesUseCase {
  List<int> execute(int max, int numberOfMines) {
    List<int> mines = [];
    Random random = new Random();
    int min = 0;
    int counter = 0;
    int rndNumber;
    while (counter != numberOfMines) {
      rndNumber = min + random.nextInt((max) - min);
      if (!mines.contains(rndNumber)) {
        mines.add(rndNumber);
        counter++;
      }
    }
    return mines;
  }
}
