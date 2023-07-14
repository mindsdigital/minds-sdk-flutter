class RequestVoiceBlocklist {
  final String audio;
  final String? externalId;
  final String? description;
  final String createdBy;
  final String? extension;
  const RequestVoiceBlocklist({
    required this.audio,
    this.externalId,
    this.description,
    required this.createdBy,
    this.extension,
  });
}
