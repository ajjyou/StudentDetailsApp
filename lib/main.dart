import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_list/Function/model_students.dart';
import 'package:student_list/Function/student_list.dart';

import 'homeLogin.dart';

Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

   await Hive.initFlutter();
   
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());

  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentList(),
    );
  }
  
}
