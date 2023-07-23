import 'package:flutter/material.dart';
import 'example.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(primary: Colors.blueAccent),
      ),
      home: const Example(),
    );
  }
}
