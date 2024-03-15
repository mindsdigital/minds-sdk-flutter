import 'detection_result.dart';

class Deepfake extends DetectionResult {
  final bool? enabled;

  const Deepfake({
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

  Deepfake.fromJson(Map<String, dynamic> json)
      : enabled = json['deepfake']['enabled'],
        super.fromJson(json['deepfake']);
}
