import '../../domain/entities/enrollment/enrollment_certify_request.dart';

class EnrollmentCertifyRequestMapper {
  static Map<String, dynamic> toMap(EnrollmentCertifyRequest request) {
    return {
      "cpf": request.cpf,
      "external_type": request.externaType,
      "created_by": request.createdBy,
    };
  }
}
