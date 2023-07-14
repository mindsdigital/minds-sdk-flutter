import '../../domain/entities/enrollment/enrollment_certify_response.dart';

class EnrollmentCertifyResponseMapper {
  static EnrollmentCertifyResponse toObject(Map<String, dynamic> map) {
    return EnrollmentCertifyResponse(
      success: map['success'],
      message: map['message'],
      status: map['status'],
    );
  }
}
