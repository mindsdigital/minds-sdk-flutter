import 'package:flutter/material.dart';
import 'package:minds_digital/minds_digital.dart';
import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MindsApiWrapper.initialize(
    environment: Environment.sandbox,
    token: 'token',
  );
  runApp(const AppWidget());
}
