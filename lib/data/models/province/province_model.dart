import 'package:freezed_annotation/freezed_annotation.dart';

part 'province_model.freezed.dart';

part 'province_model.g.dart';

@freezed
class ProvinceModel with _$ProvinceModel {
  const factory ProvinceModel({
    @JsonKey(name: 'nama') required String name,
    String? id,
  }) = _ProvinceModel;

  factory ProvinceModel.fromJson(Map<String, Object?> json) =>
      _$ProvinceModelFromJson(json);
}
