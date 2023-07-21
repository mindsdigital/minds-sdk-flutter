import 'package:universal_html/html.dart' as html;
import 'delete_local_blob_audio_usecase.dart';
import 'dart:developer' as developer;

class DeleteLocalBlobUsecaseImpl implements DeleteLocalBlobUsecase {
  @override
  void call(String url) {
    html.Url.revokeObjectUrl(url);
    developer.log("deleted local blob: $url");
  }
}
