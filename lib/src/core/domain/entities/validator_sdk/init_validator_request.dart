class InitValidatorRequest {
  final String cpf;
  final String phoneNumber;
  final int rate;
  final bool isAuthentication;
  const InitValidatorRequest({
    required this.cpf,
    required this.phoneNumber,
    required this.rate,
    required this.isAuthentication,
  });

  const InitValidatorRequest.empty()
      : cpf = "",
        phoneNumber = "",
        rate = 0,
        isAuthentication = false;
}
