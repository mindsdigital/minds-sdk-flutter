import '../../domain/entities/biometrics_reponse/deepfake.dart';
import '../../domain/entities/biometrics_reponse/liveness_response.dart';
import '../../domain/entities/biometrics_reponse/replay_attack.dart';
import '../../domain/entities/biometrics_reponse/sentence_match.dart';

class LivenessResponseMapper {
  static LivenessResponse toObject(Map<String, dynamic> map) {
    return LivenessResponse(
      status: map["status"],
      replayAttack: ReplayAttack.fromJson(map),
      deepfake: Deepfake.fromJson(map),
      sentenceMatch: SentenceMatch.fromJson(map),
    );
  }
}
