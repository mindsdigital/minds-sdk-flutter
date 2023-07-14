import 'package:minds_digital/src/core/helpers/errors/minds_failure.dart';

class DatasourceFailure extends MindsFailure {
  const DatasourceFailure(String message, StackTrace stackTrace) : super(message, stackTrace);
}
