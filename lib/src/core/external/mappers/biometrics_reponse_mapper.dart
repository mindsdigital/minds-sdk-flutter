import '../../domain/entities/biometrics_reponse/biometrics_response.dart';
import 'details_mapper.dart';
import 'error_response_mapper.dart';
import 'result_mapper.dart';

class BiometricsResponseMapper {
  static BiometricsResponse toObject(Map<String, dynamic> map) {
    return BiometricsResponse(
      success: map['success'],
      error: map['Error'] != null
          ? ErrorResponseMapper.toObject(map['error'] as Map<String, dynamic>)
          : null,
      id: map['id'],
      cpf: map['cpf'],
      externalId: map['external_id'],
      createdAt: map['created_at'],
      result: map['result'] != null
          ? ResultMapper.toObject(map['result'] as Map<String, dynamic>)
          : null,
      details: map['details'] != null
          ? DetailsMapper.toObject(map['details'] as Map<String, dynamic>)
          : null,
      rawResponse: map,
    );
  }
}
