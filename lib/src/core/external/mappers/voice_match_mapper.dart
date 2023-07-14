import '../../domain/entities/biometrics_reponse/voice_match.dart';

class VoiceMatchMapper {
  static VoiceMatch toObject(Map<String, dynamic> map) {
    return VoiceMatch(
      result: map['result'] as String,
      confidence: map['confidence'] as String,
      status: map['status'] as String,
    );
  }
}
