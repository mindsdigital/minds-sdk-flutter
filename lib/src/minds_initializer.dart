import 'package:get_it/get_it.dart';
import 'core/domain/enums/environment.dart';
import 'core/helpers/injectors.dart';
import 'core/service/minds_service.dart';

GetIt _getIt = GetIt.instance;

class MindsApiWrapper {
  const MindsApiWrapper._();
  static String? _token;
  static Environment? _environment;
  static String? get token => _token;
  static Environment? get environment => _environment;
  static MindsService get service => _getIt<MindsService>();

  static void initialize({required String token, required Environment environment}) async {
    _token = token;
    _environment = environment;
    Injectors(_getIt).configure();
  }
}
