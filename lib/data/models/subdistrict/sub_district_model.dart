import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_district_model.freezed.dart';

part 'sub_district_model.g.dart';

@freezed
class SubDistrictModel with _$SubDistrictModel {
  const factory SubDistrictModel({
    @JsonKey(name: 'nama') required String name,
    String? provinceId,
    String? cityId,
    String? districtId,
    String? id,
  }) = _SubDistrictModel;

  factory SubDistrictModel.fromJson(Map<String, Object?> json) =>
      _$SubDistrictModelFromJson(json);
}
