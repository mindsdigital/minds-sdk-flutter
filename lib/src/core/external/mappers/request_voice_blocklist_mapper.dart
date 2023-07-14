import 'package:minds_digital/minds_digital.dart';

class RequestVoiceBlocklistMapper {
  static Map<String, dynamic> toMap(RequestVoiceBlocklist request) {
    return {
      "audio": request.audio,
      "external_id": request.externalId,
      "description": request.description,
      "created_by": request.createdBy,
      "extension": request.extension,
    };
  }

  static RequestVoiceBlocklist toObject(Map<String, dynamic> map) {
    return RequestVoiceBlocklist(
      audio: map['audio'],
      externalId: map['external_id'],
      description: map['description'],
      createdBy: map['created_by'],
      extension: map['extension'],
    );
  }
}
