import '../../domain/entities/audio/audio_convert_request.dart';

class AudioRequestMapper {
  static Map<String, dynamic> toMap(AudioConvertRequest request) {
    return {
      "audio": request.audio,
      "format": request.format,
      "next_format": request.nextFormat,
    };
  }

  static AudioConvertRequest toObject(Map<String, dynamic> map) {
    return AudioConvertRequest(
      audio: map['audio'],
      format: map['format'],
      nextFormat: map['next_format'],
    );
  }
}
