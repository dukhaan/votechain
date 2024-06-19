import 'package:freezed_annotation/freezed_annotation.dart';

part 'tps_model.freezed.dart';

part 'tps_model.g.dart';

@freezed
class TPSModel with _$TPSModel {
  const factory TPSModel({
    @JsonKey(name: 'nama') required String name,
    String? provinceId,
    String? cityId,
    String? districtId,
    String? subDistrictId,
    String? id,
  }) = _TPSModel;

  factory TPSModel.fromJson(Map<String, Object?> json) =>
      _$TPSModelFromJson(json);
}
