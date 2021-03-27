import 'package:flutter/material.dart';
import 'package:stopwatch_app/screens/create_liftgroup.dart';
import 'package:stopwatch_app/screens/create_timegroup.dart';
import 'package:stopwatch_app/screens/group_lifts.dart';
import 'package:stopwatch_app/screens/group_times.dart';
import 'package:stopwatch_app/screens/lifts_form.dart';
import 'package:stopwatch_app/screens/timer.dart';
import 'package:stopwatch_app/util/route_names.dart';
import 'package:stopwatch_app/screens/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (context) => Home());
      case RouteNames.group_Times:
        return MaterialPageRoute(builder: (context) => GroupTimes(args));
      case RouteNames.add_Time_Group:
        return MaterialPageRoute(builder: (context) => CreateTimeGroup());
      case RouteNames.add_Time:
        return MaterialPageRoute(builder: (context) => Watch(args));
      case RouteNames.select_Time_Group:
        return MaterialPageRoute(builder: (context) => Home());
      case RouteNames.group_Lifts:
        return MaterialPageRoute(builder: (context) => GroupLifts(args));
      case RouteNames.add_Lift_Group:
        return MaterialPageRoute(builder: (context) => CreateLiftGroup());
      case RouteNames.add_Lift:
        return MaterialPageRoute(builder: (context) => LiftForm(args));
      case RouteNames.select_Lift_Group:
        return MaterialPageRoute(builder: (context) => Home());
      default:
        return MaterialPageRoute(builder: (context) => Home());
    }
  }
}
