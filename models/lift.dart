import 'package:stopwatch_app/util/db.dart';

class Lift {
  int id;
  int liftgroup;
  int weight;
  int quantity;
  int day;
  int month;
  int year;

  static const col_id = 'id';
  static const col_lift_group = 'lift_group';
  static const col_weight = 'weight';
  static const col_quantity = 'quantity';
  static const col_day = 'day';
  static const col_month = 'month';
  static const col_year = 'year';

  Lift(this.liftgroup, this.weight, this.quantity) {
    var currDt = DateTime.now();
    this.day = currDt.day;
    this.month = currDt.month;
    this.year = currDt.year;
  }

  Lift.fromMap(Map<String, dynamic> liftmap) {
    this.id = liftmap['id'];
    this.liftgroup = liftmap['lift_group'];
    this.weight = liftmap['weight'];
    this.quantity = liftmap['quantity'];
    this.day = liftmap['day'];
    this.month = liftmap['month'];
    this.year = liftmap['year'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': null,
      'lift_group': this.liftgroup,
      'weight': this.weight,
      'quantity': this.quantity,
      'day': this.day,
      'month': this.month,
      'year': this.year
    };
  }

  static saveLift(Lift lift) async {
    await DatabaseHelper().addLift(lift);
  }

  static Future<List<Lift>> getLifts(int group) async {
    return await DatabaseHelper().getLifts(group);
  }

  static deleteLift(int id) async {
    await DatabaseHelper().deleteLift(id);
  }

  Lift.toGoal(this.liftgroup, this.weight, this.quantity, this.day, this.month,
      this.year);

  static Future<List<Lift>> getLiftGoals(int group) async {
    return await DatabaseHelper().getLiftGoals(group);
  }

  static SaveGoal(Lift lift) async {
    return await DatabaseHelper().addLiftGoal(lift);
  }

  static DeleteGoal(int id) async {
    return await DatabaseHelper().deleteLiftGoal(id);
  }
}
