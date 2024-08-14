import 'details.dart';
import 'error_response.dart';
import 'result.dart';

class BiometricsResponse {
  final bool success;
  final ErrorResponse? error;
  final int? id;
  final String? cpf;
  final String? externalId;
  final String? createdAt;
  final String? utCreatedAt;
  final Result? result;
  final Details? details;
  final Map<String, dynamic> rawResponse;
  const BiometricsResponse({
    required this.success,
    required this.error,
    required this.id,
    required this.cpf,
    required this.externalId,
    required this.createdAt,
    required this.utCreatedAt,
    required this.result,
    required this.details,
    required this.rawResponse,
  });

  @override
  String toString() {
    return 'BiometricsResponse(success: $success, error: $error, id: $id, cpf: $cpf, externalId: $externalId, createdAt: $createdAt, utCreatedAt: $utCreatedAt, result: $result, details: $details, rawResponse: $rawResponse)';
  }
}
