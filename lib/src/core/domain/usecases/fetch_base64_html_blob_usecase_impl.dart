import 'dart:async';
import 'dart:convert';
import 'fetch_base64_html_blob_usecase.dart';
import 'package:universal_html/html.dart' as html;

class FetchBase64HtmlBlobUsecaseImpl implements FetchBase64HtmlBlobUsecase {
  @override
  Future<String?> call(String htmlPath) async {
    Completer<String?> completer = Completer<String?>();
    final request = await html.HttpRequest.request(htmlPath, responseType: 'blob');
    html.Blob blob = request.response;
    html.FileReader reader = html.FileReader();
    reader.onLoadEnd.listen((event) {
      if (reader.readyState == html.FileReader.DONE) {
        String base64Data = base64Encode(reader.result as List<int>);
        completer.complete(base64Data);
      } else {
        completer.completeError('Error loading file');
      }
    });

    reader.readAsArrayBuffer(blob);
    return completer.future;
  }
}
