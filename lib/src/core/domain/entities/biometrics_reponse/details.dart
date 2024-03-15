import 'liveness_response.dart';
import 'antispoofing.dart';
import 'flag.dart';
import 'voice_match.dart';

class Details {
  final Flag? flag;
  final AntiSpoofing? antiSpoofing;
  final LivenessResponse? liveness;
  final VoiceMatch? voiceMatch;
  const Details(
      {required this.flag,
      required this.antiSpoofing,
      required this.liveness,
      required this.voiceMatch});

  @override
  String toString() {
    return 'Details(flag: $flag, antiSpoofing: $antiSpoofing, liveness: $liveness, voiceMatch: $voiceMatch)';
  }
}
