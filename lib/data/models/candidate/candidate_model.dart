import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidate_model.freezed.dart';

part 'candidate_model.g.dart';

@freezed
class CandidateModel with _$CandidateModel {
  const factory CandidateModel({
    required int id,
    required String leadName,
    required String viceName,
    required String imageUrl,
    required String vision,
    required String mission,
  }) = _CandidateModel;

  factory CandidateModel.fromJson(Map<String, Object?> json) =>
      _$CandidateModelFromJson(json);
}
