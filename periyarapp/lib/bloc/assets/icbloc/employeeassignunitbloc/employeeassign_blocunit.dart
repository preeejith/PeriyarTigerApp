// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_eventunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_stateunit.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/employeeassignmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/employeeassignunitmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

///
class GetEmployeeUnitAssignBloc
    extends Bloc<EmployeeUnitAssignEvent, EmployeeUnitAssignState> {
  GetEmployeeUnitAssignBloc() : super(EmployeeUnitAssignState()) {
    on<GetEmployeeUnitAssign>(_getEmployeeUnitAssign);

    on<FetchEmployeeUnitAssign>(_fetchEmployeeUnitAssign);
    on<RefreshEmployeeUnitAssign>(_refreshEmployeeUnitAssign);

    on<TaskEmployeeUnitAssign>(_taskEmployeeUnitAssign);
    on<TaskEmployee2UnitAssign>(_taskEmployee2UnitAssign);

    on<DutyEmployeeassign>(_dutyEmployeeassign);
  }

  Future<FutureOr<void>> _getEmployeeUnitAssign(GetEmployeeUnitAssign event,
      Emitter<EmployeeUnitAssignState> emit) async {
    // dynamic response;

    // Map map = {
    //   "unitId": event.requestId,
    //   "empId": [event.employeelist2]
    // };

    // response = map;
    //  await db.addICUnitsAssignListdata(jsonEncode(response));

    // Fluttertoast.showToast(msg: "Download Success");
    for (int i = 0; i < event.employeelist2.length; i++) {
      await getupdateemployeelistdata(
          event.requestId, event.unittype, event.employeelist2[i]);
    }
  }

  Future<FutureOr<void>> _fetchEmployeeUnitAssign(FetchEmployeeUnitAssign event,
      Emitter<EmployeeUnitAssignState> emit) async {
    DatabaseHelper? db = DatabaseHelper.instance;
    EmployeeAssignUnitModel employeeAssignUnitModel;
    List items22 = [];

    items22 = await db.getICUnitsAssignListDownloadData();
/////employeee assign things

    print(items22);
    if (items22.isNotEmpty) {
      for (int k = 0; k < items22.length; k++) {
        employeeAssignUnitModel = await AuthRepository().employeeassignunit(
            url: '/assign/employee/inunits',
            data: jsonDecode(items22[k]['data']));

        if (employeeAssignUnitModel.status == true) {
          if (items22.isNotEmpty) {
            await db.getICUnitsAssigndeleteListDownloadData(
                int.parse(items22[k]['id'].toString()));
          }
          // emit(EmployeeUnitAssignsuccess(
          //     employeeAssignUnitModel: employeeAssignUnitModel));
        } else if (employeeAssignUnitModel.status == false) {
          emit(EmployeeUnitAssignError(
              error: employeeAssignUnitModel.msg.toString()));
        }
      }
      emit(RefreshUnitAssign());
      emit(EmployeeUnitAssignsuccess());
      // emit(RefreshUnitAssign());
    } else {
      emit(RefreshUnitAssign());
      emit(EmployeeUnitAssignsuccess());
      // emit(RefreshUnitAssign());
      // Fluttertoast.showToast(msg: "Not Assigned any employees");
    }
  }

  Future<FutureOr<void>> _refreshEmployeeUnitAssign(
      RefreshEmployeeUnitAssign event,
      Emitter<EmployeeUnitAssignState> emit) async {
    emit(RefreshUnitAssign());
  }

  Future<FutureOr<void>> _taskEmployeeUnitAssign(TaskEmployeeUnitAssign event,
      Emitter<EmployeeUnitAssignState> emit) async {
    EmployeeAssignUnitModel employeeAssignUnitModel;
    List items6 = await getAllEmployeeListdata();
    print(items6);

    if (items6.isNotEmpty) {
      for (int i = 0; i < items6.length; i++) {
        Map map = {
          "unitId": items6[i]['assignedUnitId'],
          "empId": [items6[i]['empid']]
        };
        employeeAssignUnitModel = await AuthRepository()
            .employeeassignunit(url: '/assign/employee/inunits', data: map);

        if (employeeAssignUnitModel.status == true) {
          print("hello");
        } else if (employeeAssignUnitModel.status == false) {
          print("hi");
        }
      }

      emit(RefreshUnitAssign());
      emit(EmployeeUnitAssignsuccess());
    } else {
      emit(RefreshUnitAssign());
      emit(EmployeeUnitAssignsuccess());
    }

    // emit(RefreshUnitAssign());
  }

  Future<FutureOr<void>> _taskEmployee2UnitAssign(TaskEmployee2UnitAssign event,
      Emitter<EmployeeUnitAssignState> emit) async {
    EmployeeAssignUnitModel employeeAssignUnitModel;
    List items6 = await getAllEmployeeListdata();
    print(items6);

    if (items6.isNotEmpty) {
      for (int i = 0; i < items6.length; i++) {
        Map map = {
          "unitId": items6[i]['assignedUnitId'],
          "empId": [items6[i]['empid']]
        };
        employeeAssignUnitModel = await AuthRepository()
            .employeeassignunit(url: '/assign/employee/inunits', data: map);

        if (employeeAssignUnitModel.status == true) {
          print("hello");
        } else if (employeeAssignUnitModel.status == false) {
          print("hi");
        }
      }

      // emit(RefreshUnitAssign());
      // emit(EmployeeUnitAssignsuccess());
    } else {
      // emit(RefreshUnitAssign());
      // emit(EmployeeUnitAssignsuccess());
    }

    // emit(RefreshUnitAssign());
  }
  //

  Future<FutureOr<void>> _dutyEmployeeassign(
      DutyEmployeeassign event, Emitter<EmployeeUnitAssignState> emit) async {
    EmployeeassignModel employeeassignModel;
    List items6 = await getAllEmployeeListdata();
    print(items6);

    if (items6.isNotEmpty) {
      Map map = {
        "assign": [
          for (int i = 0; i < items6.length; i++)
            {
              "empId": [items6[i]['empid']],
              "remark": items6[i]['taskAsseigned'],
            }
        ]
      };
      employeeassignModel = await AuthRepository()
          .employeeassign(url: '/assign/task/employee', data: map);

      if (employeeassignModel.status == true) {
        print("EMployee Asssiged suuccefully thank u");
      } else if (employeeassignModel.status == false) {
        emit(EmployeeAssignError(error: employeeassignModel.msg.toString()));
      }
    }
  }
}
