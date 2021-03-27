import 'package:stopwatch_app/util/db.dart';

class TimeGroup {
  int id;
  String name;
  String description;

  static const col_id = 'id';
  static const col_name = 'name';
  static const col_description = 'description';

  TimeGroup.fromForm(this.name, this.description);
  TimeGroup.fromMap(Map<String, dynamic> groupmap) {
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
    await DatabaseHelper().deleteTimeGroup(id);
  }

  static saveGroup(TimeGroup timegroup) async {
    await DatabaseHelper().addTimeGroup(timegroup);
  }

  static Future<List<TimeGroup>> getGroups() async {
    return await DatabaseHelper().getTimeGroups();
  }
}
