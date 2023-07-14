import '../../domain/entities/enrollment/enrollment_verify_response.dart';

class EnrollmentVerifyResponseMapper {
  static EnrollmentVerifyResponse toObject(Map<String, dynamic> map) {
    return EnrollmentVerifyResponse(
      success: map['success'],
      enrolled: map['enrolled'],
      certified: map['certified'],
      status: map['status'],
      message: map['message'],
    );
  }
}
