import '../../../../minds_digital.dart';

class RequestPhoneBlocklistMapper {
  static Map<String, dynamic> toMap(RequestPhoneBlocklist request) {
    return {
      "phone_number": request.phoneNumber,
      "external_id": request.externalId,
      "description": request.description,
      "created_by": request.createdBy,
    };
  }

  static RequestPhoneBlocklist toObject(Map<String, dynamic> map) {
    return RequestPhoneBlocklist(
      phoneNumber: map['phone_number'],
      externalId: map['external_id'],
      description: map['description'],
      createdBy: map['created_by'],
    );
  }
}
