import 'package:flutter/cupertino.dart';
import 'package:parambikulam/ui/assets/local/model/data_model.dart';
import 'package:sqflite/sqflite.dart';


ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);
late Database _db;
Future<void> initializeDataBase() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student(id INTEGER PRIMARY KEY,name TEXT,age Text )');
  });
}

Future<void> addStudent(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student( name,age) VALUES(?,?)', [value.name, value.age]);
  getAllStudents();
  // studentListNotifier.value.add(value);
  // studentListNotifier.notifyListeners();
}


Future<void> delStudent(StudentModel value) async {
 await _db.rawDelete('DELETE FROM student WHERE id = ?', [value.id]);
  getAllStudents();
  // studentListNotifier.value.add(value);
  // studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  studentListNotifier.value.clear();

  final _values = await _db.rawQuery('  SELECT * FROM student ');

  // print(_values);
  studentListNotifier.value.clear();
  for (var map in _values) {
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
    // studentListNotifier.notifyListeners();
  }

  // Future<void> deleteStudent(int d) async {
  //   getAllStudents();
  // }
}
