class BiometricsRequest {
  final String? audio;
  final String cpf;
  final String? externalId;
  final String? externalCustomerId;
  final String? extension;
  final String? phoneNumber;
  final bool? showDetails;
  final String? sentenceId;
  const BiometricsRequest({
    required this.audio,
    required this.cpf,
    this.externalId,
    this.externalCustomerId,
    required this.extension,
    this.phoneNumber,
    this.showDetails = false,
    this.sentenceId,
  });
}
