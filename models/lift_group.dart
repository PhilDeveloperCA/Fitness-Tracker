import 'package:stopwatch_app/util/db.dart';

class LiftGroup {
  int id;
  String name;
  String description;

  static const col_id = 'id';
  static const col_name = 'name';
  static const col_description = 'description';

  LiftGroup.fromForm(this.name, this.description);
  LiftGroup.fromMap(Map<String, dynamic> groupmap) {
    this.id = groupmap['id'];
    this.name = groupmap['name'];
    this.description = groupmap['description'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
    };
  }

  static deleteGroup(int id) async {
    await DatabaseHelper().deleteLiftGroup(id);
  }

  static saveLift(LiftGroup liftGroup) async {
    await DatabaseHelper().addLiftGroup(liftGroup);
  }

  static Future<List<LiftGroup>> getGroups() async {
    return await DatabaseHelper().getLiftGroups();
  }
}
