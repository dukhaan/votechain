import 'package:votechain/data/models/city/city_model.dart';
import 'package:votechain/data/models/district/district_model.dart';
import 'package:votechain/data/models/province/province_model.dart';
import 'package:votechain/data/models/subdistrict/sub_district_model.dart';
import 'package:votechain/data/models/tps/tps_model.dart';

abstract class LocationRepository {
  Future<List<ProvinceModel>> getProvinces();
  Future<List<CityModel>> getCities(ProvinceModel provinceModel);
  Future<List<DistrictModel>> getDistricts(CityModel cityModel);
  Future<List<SubDistrictModel>> getSubDistricts(DistrictModel districtModel);
  Future<List<TPSModel>> getTPS(SubDistrictModel subDistrictModel);
}