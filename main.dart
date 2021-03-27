import 'package:flutter/material.dart';
import 'package:stopwatch_app/util/route_generator.dart';
import 'package:stopwatch_app/timer_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      darkTheme: ThemeData.dark(),
    );
  }
}
