class InitValidatorRequest {
  final String document;
  final String phoneNumber;
  final int? phoneCountryCode;
  final int rate;
  final bool isAuthentication;
  const InitValidatorRequest({
    required this.document,
    required this.phoneNumber,
    this.phoneCountryCode,
    required this.rate,
    required this.isAuthentication,
  });

  const InitValidatorRequest.empty()
      : document = "",
        phoneNumber = "",
        phoneCountryCode = null,
        rate = 0,
        isAuthentication = false;
}
