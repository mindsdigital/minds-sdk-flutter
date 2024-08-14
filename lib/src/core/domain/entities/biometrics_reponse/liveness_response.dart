import 'deepfake.dart';
import 'replay_attack.dart';
import 'sentence_match.dart';

class LivenessResponse {
  final String? status;
  final ReplayAttack? replayAttack;
  final Deepfake? deepfake;
  final SentenceMatch? sentenceMatch;
  LivenessResponse({
    required this.status,
    required this.replayAttack,
    required this.deepfake,
    required this.sentenceMatch,
  });

  @override
  String toString() {
    return 'LivenessResponse(status: $status, replayAttack: $replayAttack, deepfake: $deepfake, sentenceMatch: $sentenceMatch)';
  }
}
