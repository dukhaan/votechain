import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:votechain/data/models/city/city_model.dart';
import 'package:votechain/data/models/district/district_model.dart';
import 'package:votechain/data/models/province/province_model.dart';
import 'package:votechain/data/models/subdistrict/sub_district_model.dart';
import 'package:votechain/data/models/tps/tps_model.dart';
import 'package:votechain/features/pick_location/data/repository/location_repository.dart';
import 'package:votechain/utils/logger.dart';

part 'location_event.dart';
part 'location_state.dart';
part 'location_bloc.freezed.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({
    required LocationRepository repository,
  }) : super(
    const LocationState.loading(),
  ) {
    _repository = repository;

    on<_GetProvinces>(
      _onGetProvinces,
    );

  }
  late final LocationRepository _repository;

  Future<void> _onGetProvinces(
      _GetProvinces event,
      Emitter<LocationState> emit,
      ) async {
    emit(const LocationState.loading());
    try {
      final list = await _repository.getProvinces();
      emit(LocationState.provinceLoaded(list));
    } catch (e, s) {
      logger.e(e.toString(), stackTrace: s);
      emit(LocationState.error(e.toString()));
    }
  }

}
