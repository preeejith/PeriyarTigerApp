// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/new/employeeassignmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class GetEmployeeAssignBloc
    extends Bloc<EmployeeAssignEvent, EmployeeAssignState> {
  GetEmployeeAssignBloc() : super(EmployeeAssignState()) {
    on<GetEmployeeAssign>(_getEmployeeAssign);
    on<FetchEmployeeAssign>(_fetchEmployeeAssign);
    on<RefreshBlocEvent>(_refreshBlocEvent);
  }

  Future<FutureOr<void>> _getEmployeeAssign(
      GetEmployeeAssign event, Emitter<EmployeeAssignState> emit) async {
    // emit(EmployeeAssigning());
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;
////to chnage
    Map map = {
      "assign": [
        for (int i = 0; i < event.assignemployeelislist.length; i++)
          {
            "empId": event.assignemployeelislist[i].empId.toString(),
            "remark": event.assignemployeelislist[i].remark.toString(),
          }
      ]
    };
////
    response = map;
    await db.addICEmployeeAssignListdata(jsonEncode(response));
  }

  Future<FutureOr<void>> _fetchEmployeeAssign(
      FetchEmployeeAssign event, Emitter<EmployeeAssignState> emit) async {
    EmployeeassignModel employeeassignModel;

    DatabaseHelper? db = DatabaseHelper.instance;

    List items24 = [];
/////////
    items24 = await db.getICEmployeeeAssignListDownloadData();

    if (items24.isNotEmpty) {
      for (int k = 0; k < items24.length; k++) {
        employeeassignModel = await AuthRepository().employeeassign(
            url: '/assign/task/employee', data: jsonDecode(items24[k]['data']));

        if (employeeassignModel.status == true) {
          await db.deleteICEmployeeAssignListdata(
              int.parse(items24[k]['id'].toString()));

          // emit(EmployeeAssignsuccess(employeeassignModel: employeeassignModel));
        } else if (employeeassignModel.status == false) {
          await db.deleteICEmployeeAssignListdata(
              int.parse(items24[k]['id'].toString()));
          emit(EmployeeAssignError(error: employeeassignModel.msg.toString()));
        }
      }
      emit(RefreshEmployAssign());
      emit(EmployeeAssignsuccess());
      // emit(RefreshEmployAssign());
    } else {
      emit(RefreshEmployAssign());
      emit(EmployeeAssignsuccess());
      //  emit(RefreshEmployAssign());
      // Fluttertoast.showToast(msg: "Not Assigned any employee ");
    }
//   ////
  }

  Future<FutureOr<void>> _refreshBlocEvent(
      RefreshBlocEvent event, Emitter<EmployeeAssignState> emit) async {
    emit(RefreshEmployAssign());
  

//   ////
  }
}
