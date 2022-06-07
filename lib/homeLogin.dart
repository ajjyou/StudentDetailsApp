import 'package:flutter/material.dart';

import 'package:student_list/Function/Function.dart';

import 'Function/model_students.dart';
class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _emailController = TextEditingController();

  final _gradeController = TextEditingController();

  var _image;

  @override
  Widget build(BuildContext context) {
    getStudent();
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('STUDENT FORM'),
          backgroundColor: Color.fromARGB(255, 91, 131, 163),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Name...',
                    fillColor: Color.fromARGB(255, 238, 243, 237),
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Age...',
                    fillColor: Color.fromARGB(255, 243, 237, 237),
                    filled: true),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextFormField(
                controller: _emailController,
                // controller: _branchController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Email...',
                    fillColor: Color.fromARGB(255, 233, 230, 230),
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: TextFormField(
                controller: _gradeController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Grade...',
                    fillColor: Color.fromARGB(255, 241, 239, 239),
                    filled: true),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                //UPLOAD

                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    var image = await getFromGallery();
                    setState(() {
                      _image = image;
                    });
                  },
                  child: Text('upload image'),
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Column(
              children: [
                //ADD

                ElevatedButton(
                  onPressed: () {
                    onAddStudentButtonClicked(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    minimumSize: Size(50, 50),
                    primary: Colors.blue,
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//EMPTY CHECK
  Future<void> onAddStudentButtonClicked(context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _email = _emailController.text.trim();
    final _grade = _gradeController.text.trim();

    if (_name.isEmpty || _age.isEmpty || _email.isEmpty || _grade.isEmpty) {
      return;
    } else {
      final studentDetails = StudentModel(
          name: _name, age: _age, email: _email, grade: _grade, image: _image);
      addStudent(studentDetails);
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: EdgeInsets.all(10),
        content: Text('successfully added')));
  }
}
