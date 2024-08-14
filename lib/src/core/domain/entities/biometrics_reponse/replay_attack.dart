import 'detection_result.dart';

class ReplayAttack extends DetectionResult {
  final bool? enabled;

  const ReplayAttack({
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

  ReplayAttack.fromJson(Map<String, dynamic> json)
      : enabled = json['replay_attack']['enabled'],
        super.fromJson(json['replay_attack']);
}
