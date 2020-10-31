import 'package:get_it/get_it.dart';
import 'package:minesweeper/layer/use_case/count_mines_next_use_case.dart';
import 'package:minesweeper/layer/use_case/get_mines_use_case.dart';

GetIt locator = GetIt.instance;
GetIt _l = locator;

void initSyncDependencies() {
  _initUseCases();
}

void _initUseCases() {
  _l.registerLazySingleton(() => GetMinesUseCase());
  _l.registerLazySingleton(() => CountMinesNextUseCase());
}
