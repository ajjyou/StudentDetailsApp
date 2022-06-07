import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/Function/Function.dart';

import 'model_students.dart';

final _updateNameController = TextEditingController();
final _updateAgeController = TextEditingController();
final _updateEmailController = TextEditingController();
final _updateGradeController = TextEditingController();
ImagePicker imagePicker = ImagePicker();
var image;

Future<void> updateStudent(BuildContext context, int index) async {
  _updateNameController.text = studentListNotifier.value[index].name;
  _updateAgeController.text = studentListNotifier.value[index].age;
  _updateEmailController.text = studentListNotifier.value[index].email;
  _updateGradeController.text = studentListNotifier.value[index].grade;

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        
        
        title: const Text('Update Student Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) {},
              controller: _updateNameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextField(
              onChanged: (value) {},
              controller: _updateAgeController,
              decoration: const InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              onChanged: (value) {},
              controller: _updateEmailController,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              onChanged: (value) {},
              controller: _updateGradeController,
              decoration: const InputDecoration(hintText: 'Grade'),
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              XFile? img =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              if (img == null ) {
                image = studentListNotifier.value[index].image;
              } else {
                image = img.path ;

              }
            },
            icon: const Icon(Icons.image),
            label: const Text('upload image'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              onUpdateButtonClicked(index, context);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.done),
            label: const Text('submit'),
          ),
        ],
      );
    },
  );
}

Future<void> onUpdateButtonClicked(int index, context) async {
  final _updateName = _updateNameController.text.trim();
  final _updateAge = _updateAgeController.text.trim();
  final _updateEmail = _updateEmailController.text.trim();
  final _updateGrade = _updateGradeController.text.trim();
  if (_updateName.isEmpty ||
      _updateAge.isEmpty ||
      _updateEmail.isEmpty ||
      _updateGrade.isEmpty) {
    return;
  } else {
    final _values = StudentModel(
        name: _updateName,
        age: _updateAge,
        email: _updateEmail,
        grade: _updateGrade,
        image: image??studentListNotifier.value[index].image);
        
    updated(_values, index);
  }
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      content: Text('List Updated')));
}

Future<void> updated(StudentModel values, int index) async {
  final studentDb = await Hive.openBox<StudentModel>('student_db');
  final key = studentDb.keys;
  final savedKey = key.elementAt(index);
  studentDb.put(savedKey, values);
  image=null;
  // studentListNotifier.notifyListeners();
  getStudent();
}
