import 'detection_result.dart';

class VoiceMatch extends DetectionResult {
  const VoiceMatch({
    required String? result,
    required String? confidence,
    required String? status,
    required double? score,
    required double? threshold,
  }) : super(
          result: result,
          confidence: confidence,
          status: status,
          score: score,
          threshold: threshold,
        );

  VoiceMatch.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
