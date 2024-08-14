import 'detection_result.dart';

class SentenceMatch extends DetectionResult {
  final bool? enabled;

  const SentenceMatch({
    this.enabled = false,
    required String? status,
    required String? result,
    required String? confidence,
    required double? score,
    required double? threshold,
  }) : super(
          status: status,
          result: result,
          confidence: confidence,
          score: score,
          threshold: threshold,
        );

  SentenceMatch.fromJson(Map<String, dynamic> json)
      : enabled = json['sentence_match']['enabled'],
        super.fromJson(json['sentence_match']);
}
