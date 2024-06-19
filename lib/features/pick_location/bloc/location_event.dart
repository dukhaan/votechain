part of 'location_bloc.dart';

@freezed
class LocationEvent with _$LocationEvent {
  const factory LocationEvent.started() = _Started;
  const factory LocationEvent.getProvinces() = _GetProvinces;
  const factory LocationEvent.getCities(ProvinceModel province) = _GetCities;
  const factory LocationEvent.getDistricts(CityModel city) = _GetDistricts;
  const factory LocationEvent.getSubDistricts(DistrictModel district) = _GetSubDistricts;
  const factory LocationEvent.getTps(TPSModel tps) = _GetTPS;
  const factory LocationEvent.selectProvince(ProvinceModel data) = _SelectProvince;
  const factory LocationEvent.selectCity(CityModel data) = _SelectCity;
  const factory LocationEvent.selectDistrict(DistrictModel data) = _SelectDistrict;
  const factory LocationEvent.selectSubDistrict(SubDistrictModel data) = _SelectSubDistrict;
  const factory LocationEvent.selectTps(TPSModel data) = _SelectTPS;
}
