import '../../domain/entities/biometrics_reponse/details.dart';
import 'flag_mapper.dart';
import 'voice_match_mapper.dart';

class DetailsMapper {
  static Details toObject(Map<String, dynamic> map) {
    return Details(
      flag: map['flag'] != null ? FlagMapper.toObject(map['flag'] as Map<String, dynamic>) : null,
      voiceMatch: map['voice_match'] != null
          ? VoiceMatchMapper.toObject(map['voice_match'] as Map<String, dynamic>)
          : null,
    );
  }
}
