import '../../domain/entities/biometrics_reponse/error_response.dart';

class ErrorResponseMapper {
  static ErrorResponse toObject(Map<String, dynamic> map) {
    return ErrorResponse(
      code: map['code'] as String,
      description: map['description'] as String,
    );
  }
}
