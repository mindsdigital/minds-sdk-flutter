class RequestPhoneBlocklist {
  final String phoneNumber;
  final String? externalId;
  final String? description;
  final String createdBy;
  const RequestPhoneBlocklist({
    required this.phoneNumber,
    this.externalId,
    this.description,
    required this.createdBy,
  });
}
