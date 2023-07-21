import 'dart:convert';
import 'dart:io';

class AudioHelper {
  const AudioHelper._();
  static Future<String> convertFileToBase64(File audioFile) async {
    final audioBytes = await _readFileBytes(audioFile);
    final base64Audio = base64Encode(audioBytes);
    return base64Audio;
  }

  static Future<String> convertPathToBase64(String audioPath) async {
    final audioFile = File(audioPath);
    final audioBytes = await _readFileBytes(audioFile);
    final base64Audio = base64Encode(audioBytes);
    return base64Audio;
  }

  static Future<List<int>> _readFileBytes(File file) async {
    try {
      final bytes = await file.readAsBytes();
      return bytes;
    } catch (e) {
      throw Exception('Falha ao ler os bytes do arquivo de áudio $e');
    }
  }
}
