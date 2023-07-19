import 'package:universal_html/html.dart' as html;
import 'delete_local_blob_audio_usecase.dart';

class DeleteLocalBlobUsecaseImpl implements DeleteLocalBlobUsecase {
  @override
  void call(String url) {
    html.Url.revokeObjectUrl(url);
  }
}
