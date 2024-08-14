class BiometricsRequest {
  final String audio;
  final String document;
  final String? externalId;
  final String? externalCustomerId;
  final String extension;
  final String? phoneNumber;
  final bool? showDetails;
  final bool? certification;
  final bool? insertOnQuarantine;
  final String? sentenceId;
  const BiometricsRequest({
    required this.audio,
    required this.document,
    this.externalId,
    this.externalCustomerId,
    required this.extension,
    this.phoneNumber,
    this.showDetails = false,
    this.certification = false,
    this.insertOnQuarantine = false,
    this.sentenceId,
  });
}
