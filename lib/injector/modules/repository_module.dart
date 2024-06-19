import 'package:votechain/data/repository/contact_repository.dart';
import 'package:votechain/data/repository/contract_repository_impl.dart';
import 'package:votechain/features/pick_location/data/repository/location_repository.dart';
import 'package:votechain/features/pick_location/data/repository/location_repository_impl.dart';
import 'package:votechain/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    Injector.instance
      ..registerFactory<ContractRepository>(
        ContractRepositoryImpl.new,
      )
      ..registerFactory<LocationRepository>(
        LocationRepositoryImpl.new,
      );
  }
}
