import 'flag.dart';
import 'voice_match.dart';

class Details {
  final Flag? flag;
  final VoiceMatch? voiceMatch;
  const Details({required this.flag, required this.voiceMatch});

  @override
  String toString() => 'Details(flag: $flag, voiceMatch: $voiceMatch)';
}
