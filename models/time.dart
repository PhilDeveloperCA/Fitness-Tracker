import 'package:stopwatch_app/util/db.dart';

class Time {
  int id;
  int time_group;
  int seconds;
  int day;
  int month;
  int year;

  static const col_id = 'id';
  static const col_time_group = 'time_group';
  static const col_seconds = 'seconds';
  static const col_day = 'day';
  static const col_month = 'month';
  static const col_year = 'year';

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'time_group': this.time_group,
      'seconds': this.seconds,
      'day': this.day,
      'month': this.month,
      'year': this.year
    };
  }

  static deleteTime(int id) async {
    await DatabaseHelper().deleteTime(id);
  }

  static saveTime(Time time) async {
    await DatabaseHelper().addTime(time);
  }

  Time(this.time_group, this.seconds) {
    var currDt = DateTime.now();
    this.day = currDt.day;
    this.month = currDt.month;
    this.year = currDt.year;
  }

  Time.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.time_group = map['time_group'];
    this.seconds = map['seconds'];
    this.day = map['day'];
    this.month = map['month'];
    this.year = map['year'];
  }

  static saveGoal(Time time) async {
    await DatabaseHelper().addTimeGoal(time);
  }

  static Future<List<Time>> getTimes(int group_id) async {
    return await DatabaseHelper().getTimes(group_id);
  }

  static Future<List<Time>> getGoals(int group_id) async {
    return await DatabaseHelper().getTimeGoals(group_id);
  }

  static DeleteGoal(int id) async {
    return await DatabaseHelper().deleteTimeGoal(id);
  }

  Time.toGoal(this.time_group, this.seconds, this.day, this.month, this.year);
}
