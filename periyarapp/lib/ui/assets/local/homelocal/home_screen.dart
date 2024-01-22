
import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/local/function/db_function.dart';
import 'package:parambikulam/ui/assets/local/widget/add_student_widget.dart';
import 'package:parambikulam/ui/assets/local/widget/list_student_widget.dart';


class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AddStudentWidget(),
          const Expanded(child: ListStudentWidget()),
        ],
      )),
    );
  }
}
