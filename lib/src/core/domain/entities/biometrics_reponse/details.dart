import 'antispoofing.dart';
import 'flag.dart';
import 'voice_match.dart';

class Details {
  final Flag? flag;
  final VoiceMatch? voiceMatch;
  final AntiSpoofing? antiSpoofing;
  const Details({required this.flag, required this.voiceMatch, required this.antiSpoofing});

  @override
  String toString() => 'Details(flag: $flag, voiceMatch: $voiceMatch, antiSpoofing: $antiSpoofing)';
}
