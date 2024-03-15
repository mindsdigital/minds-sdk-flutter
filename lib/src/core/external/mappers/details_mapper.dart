import '../../domain/entities/biometrics_reponse/voice_match.dart';
import 'antispoofing_mapper.dart';
import 'liveness_response_mapper.dart';
import '../../domain/entities/biometrics_reponse/details.dart';
import 'flag_mapper.dart';

class DetailsMapper {
  static Details toObject(Map<String, dynamic> map) {
    return Details(
      flag: map['flag'] != null ? FlagMapper.toObject(map['flag'] as Map<String, dynamic>) : null,
      antiSpoofing:
          map['antispoofing'] != null ? AntiSpoofingMapper.fromObject(map['antispoofing']) : null,
      liveness: LivenessResponseMapper.toObject(map["liveness"]),
      voiceMatch: map['voice_match'] != null
          ? VoiceMatch.fromJson(map['voice_match'] as Map<String, dynamic>)
          : null,
    );
  }
}
