import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:votechain/data/models/city/city_model.dart';
import 'package:votechain/data/models/district/district_model.dart';
import 'package:votechain/data/models/province/province_model.dart';
import 'package:votechain/data/models/subdistrict/sub_district_model.dart';
import 'package:votechain/data/models/tps/tps_model.dart';
import 'package:votechain/features/pick_location/data/repository/location_repository.dart';

class LocationRepositoryImpl extends LocationRepository {
  @override
  Future<List<CityModel>> getCities(ProvinceModel provinceModel) async {
    // TODO: implement getCities
    throw UnimplementedError();
  }

  @override
  Future<List<DistrictModel>> getDistricts(CityModel cityModel) async {
    // TODO: implement getDistricts
    throw UnimplementedError();
  }

  @override
  Future<List<ProvinceModel>> getProvinces() async {
    final list = <ProvinceModel>[];
    final rawJson = await rootBundle.loadString('assets/json/provinsi.json');
    final json = jsonDecode(rawJson) as List<dynamic>;
    for (final data in json) {
      final province = ProvinceModel.fromJson(data);
      list.add(province);
    }
    return list;
  }

  @override
  Future<List<SubDistrictModel>> getSubDistricts(DistrictModel districtModel) async {
    // TODO: implement getSubDistricts
    throw UnimplementedError();
  }

  @override
  Future<List<TPSModel>> getTPS(SubDistrictModel subDistrictModel) async {
    // TODO: implement getTPS
    throw UnimplementedError();
  }

}