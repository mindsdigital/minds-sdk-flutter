class AudioConvertRequest {
  final String audio;
  final String format;
  final String nextFormat;

  const AudioConvertRequest({
    required this.audio,
    required this.format,
    required this.nextFormat,
  });
}
