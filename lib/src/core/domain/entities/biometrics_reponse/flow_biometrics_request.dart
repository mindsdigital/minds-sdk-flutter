class FlowBiometricsRequest {
  final String cpf;
  final String? externalId;
  final String? externalCustomerId;
  final String? phoneNumber;
  final bool? showDetails;
  final String? sentenceId;
  const FlowBiometricsRequest({
    required this.cpf,
    this.externalId,
    this.externalCustomerId,
    this.phoneNumber,
    this.showDetails = false,
    this.sentenceId,
  });
}
