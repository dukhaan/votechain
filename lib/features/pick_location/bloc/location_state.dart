part of 'location_bloc.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const factory LocationState.loaded() = _Loaded;
  const factory LocationState.error(String message) = _Error;
  const factory LocationState.provinceLoaded(List<ProvinceModel> provinceModel) = _ProvinceLoaded;
  const factory LocationState.cityLoaded(List<CityModel> cityModel) = _CityLoaded;
  const factory LocationState.districtLoaded(List<DistrictModel> districtModel) = _DistrictLoaded;
  const factory LocationState.subDistrictLoaded(List<SubDistrictModel> subDistrictModel) = _SubDistrictLoaded;
  const factory LocationState.tpsLoaded(List<TPSModel> tpsModel) = _TPSLoaded;
}
