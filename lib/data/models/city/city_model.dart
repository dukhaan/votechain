import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.freezed.dart';

part 'city_model.g.dart';

@freezed
class CityModel with _$CityModel {
  const factory CityModel({
    @JsonKey(name: 'nama') required String name,
    String? provinceId,
    String? id,
  }) = _CityModel;

  factory CityModel.fromJson(Map<String, Object?> json) =>
      _$CityModelFromJson(json);
}
