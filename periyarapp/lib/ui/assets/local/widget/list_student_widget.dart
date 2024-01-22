
import 'package:flutter/material.dart';
import 'package:parambikulam/ui/assets/local/function/db_function.dart';
import 'package:parambikulam/ui/assets/local/model/data_model.dart';


class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
              return ListTile(
                leading: Text(data.id.toString()),
                title: Text(data.name),
                subtitle: Text(data.age),
                

              );
            },
            separatorBuilder: (ctx, index) {
              return const Divider();
            },
            itemCount: studentList.length,
          );
        });
  }
}
