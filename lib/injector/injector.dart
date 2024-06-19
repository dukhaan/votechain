import 'package:get_it/get_it.dart';
import 'package:votechain/injector/modules/repository_module.dart';

class Injector {
  Injector._();
  static GetIt instance = GetIt.instance;

  static void init() {
    RepositoryModule.init();
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
