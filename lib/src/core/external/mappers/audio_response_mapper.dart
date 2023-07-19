import '../../domain/entities/audio/audio_response.dart';

class AudioResponseMapper {
  static AudioResponse toObject(Map<String, dynamic> map) {
    return AudioResponse(
      success: map['success'],
      status: map['status'],
      audio: map['audio'],
      format: map['format'],
    );
  }
}
