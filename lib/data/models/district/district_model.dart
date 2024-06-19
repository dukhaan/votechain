import 'package:freezed_annotation/freezed_annotation.dart';

part 'district_model.freezed.dart';

part 'district_model.g.dart';

@freezed
class DistrictModel with _$DistrictModel {
  const factory DistrictModel({
    @JsonKey(name: 'nama') required String name,
    String? provinceId,
    String? cityId,
    String? id,
  }) = _DistrictModel;

  factory DistrictModel.fromJson(Map<String, Object?> json) =>
      _$DistrictModelFromJson(json);
}
