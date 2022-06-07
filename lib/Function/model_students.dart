import 'package:hive_flutter/hive_flutter.dart';
part 'model_students.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final  age;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String grade;
  @HiveField(4)
  final  image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.email,
      required this.grade,
      required this.image,
      });
}

