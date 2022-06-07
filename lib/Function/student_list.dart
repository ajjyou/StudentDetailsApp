import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_list/Function/model_students.dart';
import 'package:student_list/detail_student.dart';
import 'package:student_list/homeLogin.dart';
import 'package:student_list/search_student.dart';

import 'Function.dart';
import 'update_student._list.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getStudent();
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text('STUDENTS LIST'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearch());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        backgroundColor: Colors.transparent,
        body: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext ctx, List<StudentModel> studentlist,
                Widget? child) {
              return ListView.separated(
                itemBuilder: ((context, index) {
                  final data = studentlist[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) =>
                              StudentProfile(index: index))));
                    },
                    leading:data.image == null ? CircleAvatar():
                    CircleAvatar(
                      backgroundImage: FileImage(File(data.image)),
                    ),
                    title: Text(
                      data.name,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                    ),
                    subtitle: Text(data.email),
                  );
                }),
                separatorBuilder: (ctx, index) {
                  return Divider();
                },
                itemCount: studentlist.length,
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ScreenHome()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        deleteStudent(index);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Contents"),
      content: Text("Are You Sure? "),
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
