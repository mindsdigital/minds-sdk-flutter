enum Environment {
  staging(
    baseUrl: "https://staging-voice-api.minds.digital/v2.1",
    speakerUrl: "https://staging-speaker-api.minds.digital/v2",
  ),
  sandbox(
    baseUrl: "https://sandbox-voice-api.minds.digital/v2.1",
    speakerUrl: "https://sandbox-speaker-api.minds.digital/v2",
  ),
  production(
    baseUrl: "https://voice-api.minds.digital/v2.1",
    speakerUrl: "https://speaker-api.minds.digital/v2",
  );

  final String baseUrl;
  final String speakerUrl;
  const Environment({required this.baseUrl, required this.speakerUrl});
}
