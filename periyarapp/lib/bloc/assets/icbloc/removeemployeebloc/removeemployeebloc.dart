// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/removeemployeebloc/removeemployeeevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/removeemployeebloc/removeemployeestate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/removeemployeemodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

/////
class GetRemoveEmployeeBloc
    extends Bloc<RemoveEmployeeEvent, RemoveEmployeeState> {
  GetRemoveEmployeeBloc() : super(RemoveEmployeeState()) {
    on<GetRemoveEmployee>(_getRemoveEmployee);
    on<FetchRemoveEmployee>(_fetchRemoveEmployee);
  }

  Future<FutureOr<void>> _getRemoveEmployee(
      GetRemoveEmployee event, Emitter<RemoveEmployeeState> emit) async {
    emit(RemoveEmployeeing());

    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    Map map = {
      "unitId": event.unitId,
      "empId": event.empId,
    };
    response = map;
    await db.addICEmployeeAssigndelListdata(jsonEncode(response));
  }

  Future<FutureOr<void>> _fetchRemoveEmployee(
      FetchRemoveEmployee event, Emitter<RemoveEmployeeState> emit) async {
    emit(RemoveEmployeeing());

    RemoveEmployeeModel removeEmployeeModel;

    DatabaseHelper? db = DatabaseHelper.instance;
    List items28 = [];
    items28 = await db.getICEmployeeAssigndelListDownloadData();
    print(items28);

    if (items28.isNotEmpty) {
      for (int k = 0; k < items28.length; k++) {
        removeEmployeeModel = await AuthRepository().removeemployee(
            url: '/remove/employee', data: jsonDecode(items28[k]['data']));

        if (removeEmployeeModel.status == true) {
          await db.deleteICEmployeeAssigndelListdata(
              int.parse(items28[k]['id'].toString()));

          // emit(RemoveEmployeesuccess(removeEmployeeModel: removeEmployeeModel));
        } else if (removeEmployeeModel.status == false) {
          emit(RemoveEmployeeError(error: removeEmployeeModel.msg.toString()));
        }
      }
    }
  }
}
