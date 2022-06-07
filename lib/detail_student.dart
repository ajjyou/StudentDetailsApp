import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_list/Function/model_students.dart';
import 'package:student_list/Function/student_list.dart';

import 'Function/Function.dart';
import 'Function/update_student._list.dart';

class StudentProfile extends StatelessWidget {
  Widget styldiv = const Divider(
    color: Color.fromARGB(255, 128, 119, 117),
    thickness: 2,
    indent: 20,
    endIndent: 20,
  );
  final index;
  StudentProfile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentlist, Widget? child) {
          final data = studentlist[this.index];
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Details'),
              actions: [
                IconButton(
                  onPressed: () {
                    showAlertDialog(context, index);
                    //  Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                ),
              ],
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Container(
                  height: 500,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      // Container(
                      //     child: CircleAvatar(
                      //   backgroundImage: FileImage(File(data.image!)),
                      //   radius: 100,
                      // ),
                      // )
                      Column(
                        children: [
                          data.image == null
                              ? const CircleAvatar(
                                radius: 100,
                              )
                              : Image(
                                  image: FileImage(File(data.image!)),
                                  height: 300,
                                  width: double.infinity,
                                ),
                          const SizedBox(
                            height: 3,
                          ),
                          
                          styldiv,
                          display("Name:", data.name.toUpperCase()),
                          styldiv,
                          display("Age:", data.age),
                          styldiv,
                          display("Email:", data.email),
                          styldiv,
                          display("Grade:", data.grade),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
            // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                updateStudent(context, index);
              },
              child: const Icon(Icons.edit),
            ),
          );
        });
  }

  Widget display(field, data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          field,
          style: const TextStyle(fontSize: 25),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          data,
          style: const TextStyle(fontSize: 25),
        )
      ],
    );
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteStudent(index);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => StudentList()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Contents"),
      content: const Text("Are You Sure? "),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
