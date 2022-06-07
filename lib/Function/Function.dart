import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/Function/model_students.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

//ADD

Future<void> addStudent(StudentModel value) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  // studentDb.put(value.id, value);
  await studentDb.add(value);
  studentListNotifier.value.add(value);
  studentListNotifier.notifyListeners();
}

//VIEW

Future<void> getStudent() async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDb.values);
  studentListNotifier.notifyListeners();
}

//DELETE

Future<void> deleteStudent(int id) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final key = studentDb.keys;
  final saved_key = key.elementAt(id);
  await studentDb.delete(saved_key);
  getStudent();
}

//GALLERY

getFromGallery() async {
  XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
  return img!.path;
}



