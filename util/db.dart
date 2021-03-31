import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stopwatch_app/models/lift.dart';
import 'package:stopwatch_app/models/lift_group.dart';
import 'package:stopwatch_app/models/time.dart';
import 'package:stopwatch_app/models/time_group.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  //String Time Groups

  static Database _database;

  get helperDatabase => _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //table Names
  static const timedgroup = 'time_name';
  static const liftgroup = 'lift_group';
  static const time = 'times';
  static const lift = 'lifts';
  static const lift_goals = 'liftgoals';
  static const time_goals = 'timegoals';

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'fitness.db';

    var notesDatabase = await openDatabase(path,
        version: 2, onCreate: _createDb, onConfigure: _configureDb);
    return notesDatabase;
  }

  void _configureDb(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        '''CREATE TABLE $timedgroup(${TimeGroup.col_id} INTEGER PRIMARY KEY, ${TimeGroup.col_name} TEXT, ${TimeGroup.col_description} TEXT)''');
    await db.execute(
        '''CREATE TABLE $liftgroup(${LiftGroup.col_id} INTEGER PRIMARY KEY, ${LiftGroup.col_name} TEXT, ${LiftGroup.col_description} TEXT)''');
    await db.execute(
        '''CREATE TABLE $time(${Time.col_id} INTEGER PRIMARY KEY, ${Time.col_time_group} INTEGER, ${Time.col_seconds} INTEGER, 
                ${Time.col_day} INTEGER, ${Time.col_month} INTEGER, ${Time.col_year} INTEGER, 
                      FOREIGN KEY(${Time.col_time_group}) REFERENCES $timedgroup(id) ON DELETE CASCADE)''');
    await db.execute(
        '''CREATE TABLE $lift(${Lift.col_id} INTEGER PRIMARY KEY, ${Lift.col_lift_group} INTEGER, ${Lift.col_weight} INTEGER, ${Lift.col_quantity} INTEGER, 
                ${Lift.col_day} INTEGER, ${Lift.col_month} INTEGER, ${Lift.col_year} INTEGER, 
                      FOREIGN KEY(${Lift.col_lift_group}) REFERENCES $liftgroup(id) ON DELETE CASCADE)''');
    await db.execute(
        '''CREATE TABLE $time_goals(${Time.col_id} INTEGER PRIMARY KEY, ${Time.col_time_group} INTEGER, ${Time.col_seconds} INTEGER, 
                ${Time.col_day} INTEGER, ${Time.col_month} INTEGER, ${Time.col_year} INTEGER, 
                      FOREIGN KEY(${Time.col_time_group}) REFERENCES $timedgroup(id) ON DELETE CASCADE)''');
    await db.execute(
        '''CREATE TABLE $lift_goals(${Lift.col_id} INTEGER PRIMARY KEY, ${Lift.col_lift_group} INTEGER, ${Lift.col_weight} INTEGER, ${Lift.col_quantity} INTEGER, 
                ${Lift.col_day} INTEGER, ${Lift.col_month} INTEGER, ${Lift.col_year} INTEGER, 
                      FOREIGN KEY(${Lift.col_lift_group}) REFERENCES $liftgroup(id) ON DELETE CASCADE)''');
  }

  Future<int> getMaxId(String tablename) async {
    Database db = await database;
    List<Map<String, dynamic>> map =
        await db.rawQuery('SELECT MAX(id) FROM $tablename ');
    dynamic id = map[0]['MAX(id)'];
    id = id == null ? 1 : id + 1;
    return id;
  }

  addTimeGroup(TimeGroup timegroup) async {
    timegroup.id = await getMaxId(timedgroup);
    Database db = await database;
    await db.insert(timedgroup, timegroup.toMap());
  }

  deleteTimeGroup(int id) async {
    Database db = await database;
    print('$id');
    db.delete(timedgroup, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TimeGroup>> getTimeGroups() async {
    Database db = await database;
    List<Map<String, dynamic>> timemap = await db.query(timedgroup);
    return timemap.map((map) => TimeGroup.fromMap(map)).toList();
  }

  addLiftGroup(LiftGroup lift) async {
    lift.id = await getMaxId(liftgroup);
    Database db = await database;
    await db.insert(liftgroup, lift.toMap());
  }

  deleteLiftGroup(int id) async {
    Database db = await database;
    db.delete(liftgroup, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<LiftGroup>> getLiftGroups() async {
    Database db = await database;
    List<Map<String, dynamic>> liftmap = await db.query(liftgroup);
    return liftmap.map((map) => LiftGroup.fromMap(map)).toList();
  }

  addLift(Lift new_lift) async {
    new_lift.id = await getMaxId(lift);
    Database db = await database;
    await db.insert(lift, new_lift.toMap());
  }

  deleteLift(int id) async {
    Database db = await database;
    await db.delete(lift, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Lift>> getLifts(int group_id) async {
    Database db = await database;
    List<Map<String, dynamic>> liftmaps = await db.query(lift,
        where: '${Lift.col_lift_group} = ? ', whereArgs: [group_id]);
    return liftmaps.map((liftmap) => Lift.fromMap(liftmap)).toList();
  }

  addTime(Time new_time) async {
    new_time.id = await getMaxId(time);
    Database db = await database;
    await db.insert(time, new_time.toMap());
  }

  deleteTime(int time_id) async {
    Database db = await database;
    await db.delete(time, where: 'id = ?', whereArgs: [time_id]);
  }

  Future<List<Time>> getTimes(int group_id) async {
    Database db = await database;
    List<Map<String, dynamic>> timemaps = await db.query(time,
        where: '${Time.col_time_group} = ?', whereArgs: [group_id]);
    return timemaps.map((timemap) => Time.fromMap(timemap)).toList();
  }

  addTimeGoal(Time new_time) async {
    new_time.id = await getMaxId(time_goals);
    Database db = await database;
    await db.insert(time_goals, new_time.toMap());
  }

  deleteTimeGoal(int time_id) async {
    Database db = await database;
    await db.delete(time_goals, where: 'id = ?', whereArgs: [time_id]);
  }

  addLiftGoal(Lift new_lift) async {
    new_lift.id = await getMaxId(lift_goals);
    Database db = await database;
    await db.insert(lift_goals, new_lift.toMap());
  }

  deleteLiftGoal(int id) async {
    Database db = await database;
    await db.delete(lift_goals, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Lift>> getLiftGoals(int group_id) async {
    Database db = await database;
    List<Map<String, dynamic>> liftmaps = await db.query(lift_goals,
        where: '${Lift.col_lift_group} = ? ', whereArgs: [group_id]);
    return liftmaps.map((liftmap) => Lift.fromMap(liftmap)).toList();
  }

  Future<List<Time>> getTimeGoals(int group_id) async {
    Database db = await database;
    List<Map<String, dynamic>> timemaps = await db.query(time_goals,
        where: '${Time.col_time_group} = ?', whereArgs: [group_id]);
    return timemaps.map((timemap) => Time.fromMap(timemap)).toList();
  }
}
