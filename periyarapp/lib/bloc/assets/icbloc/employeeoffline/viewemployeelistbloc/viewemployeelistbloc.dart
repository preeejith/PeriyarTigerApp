import 'dart:async';
//////
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeoffline/viewemployeelistbloc/viewemployeelistevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeoffline/viewemployeelistbloc/viewemployeeliststate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/viewallemployeemodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetViewEmployeeListBloc
    extends Bloc<ViewEmployeeListEvent, ViewEmployeeListState> {
  GetViewEmployeeListBloc() : super(ViewEmployeeListState()) {
    on<GetViewEmployeeListEvent>(_getViewEmployeeListEvent);
  }

  Future<FutureOr<void>> _getViewEmployeeListEvent(
      GetViewEmployeeListEvent event,
      Emitter<ViewEmployeeListState> emit) async {
    emit(ViewingEmployeeList());
    ViewAllEmployeeModel viewAllEmployeeModel;
    Map map = {};

    viewAllEmployeeModel = await AuthRepository()
        .viewallemployee2(url: '/get/all/employee', data: map);
    if (viewAllEmployeeModel.status == true) {
      for (int i = 0; i < viewAllEmployeeModel.data!.length; i++) {
        final status = viewAllEmployeeModel.data![i].status == null
            ? ""
            : viewAllEmployeeModel.data![i].status;

        final empid = viewAllEmployeeModel.data![i].id == null
            ? ""
            : viewAllEmployeeModel.data![i].id;
        final phonenumber = viewAllEmployeeModel.data![i].phoneNumber == null
            ? ""
            : viewAllEmployeeModel.data![i].phoneNumber;
        final role = viewAllEmployeeModel.data![i].role == null
            ? ""
            : viewAllEmployeeModel.data![i].role;
        final username = viewAllEmployeeModel.data![i].userName == null
            ? ""
            : viewAllEmployeeModel.data![i].userName;

        final dob = viewAllEmployeeModel.data![i].dob == null
            ? ""
            : viewAllEmployeeModel.data![i].dob;
        final gender = viewAllEmployeeModel.data![i].gender == null
            ? ""
            : viewAllEmployeeModel.data![i].gender;

        final assiginedUnitid =
            viewAllEmployeeModel.data![i].assiginedUnitId == null
                ? ""
                : viewAllEmployeeModel.data![i].assiginedUnitId;
        final assignedTo = viewAllEmployeeModel.data![i].assignedTo == null
            ? ""
            : viewAllEmployeeModel.data![i].assignedTo;
        final createddate = viewAllEmployeeModel.data![i].createDate == null
            ? ""
            : viewAllEmployeeModel.data![i].createDate;
        final updateddate = viewAllEmployeeModel.data![i].updateDate == null
            ? ""
            : viewAllEmployeeModel.data![i].updateDate;
        final taskAsseigned =
            viewAllEmployeeModel.data![i].taskAsseigned == null
                ? ""
                : viewAllEmployeeModel.data![i].taskAsseigned;
        final change = "false";

        if (empid!.isEmpty) {
          return null;
        } else {
          Map data = {
            'status': status,
            'empid': empid,
            'phonenumber': phonenumber,
            'role': role,
            'userName': username,
            'dob': dob,
            'gender': gender,
            'assignedUnitId': assiginedUnitid,
            'assignedTo': assignedTo,
            'createdate': createddate,
            'updated': updateddate,
            'change': change,
            'taskAsseigned': taskAsseigned,
            'present': "true"
          };
          print(data);
          getemployeelist(data);
        }
      }
      emit(ViewEmployeeListSuccess(viewAllEmployeeModel: viewAllEmployeeModel));
    } else {
      emit(ViewEmployeeListError(error: viewAllEmployeeModel.msg.toString()));
    }
  }
}
//////