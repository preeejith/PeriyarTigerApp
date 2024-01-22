import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/authbloc/employeelogin_event.dart';
import 'package:parambikulam/bloc/assets/authbloc/employeelogin_state.dart';

import 'package:parambikulam/data/models/assetsmodel/login_employeemodel.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/loginsucessemployee_model.dart';
import 'package:parambikulam/utils/pref_manager.dart';

/////
class GetEmployeeloginBloc
    extends Bloc<EmployeeloginEvent, EmployeeloginState> {
  GetEmployeeloginBloc() : super(EmployeeloginState()) {
    on<Employeeloginentry>(_employeeloginentry);
  }

  Future<FutureOr<void>> _employeeloginentry(
      Employeeloginentry event, Emitter<EmployeeloginState> emit) async {
    emit(Employeelogin());
    EmployeeloginModel employeeloginModel;
    EmployeeLoginSuccessModel employeeLoginSuccessModel;
    Map map = {
      "phonenumber": event.phonenumber,
      "password": event.password,
    };

    employeeloginModel =
        await AuthRepository().employeelogin(url: '/employee/login', data: map);

    if (employeeloginModel.status == true) {
      await PrefManager.setIsLoggedIn(true);

      await PrefManager.setToken(employeeloginModel.token);

      employeeLoginSuccessModel = await AuthRepository()
          .employeeloginsuccess(url: '/employee/home', data: map);
      if (employeeLoginSuccessModel.status == true) {
        await PrefManager.setRole(
            employeeLoginSuccessModel.data.assiginedUnitId.type);
        await PrefManager.setOnline("initial");

        if (employeeLoginSuccessModel.data.assiginedUnitId.type == "Ic") {
          emit(Employeeloginsuccess(
              employeeLoginSuccessModel: employeeLoginSuccessModel));
          //////
          // await PrefManager.setRole(employeeLoginSuccessModel.data.assiginedUnitId.type);
        } else if (employeeLoginSuccessModel.data.assiginedUnitId.type ==
            "Production unit") {
          emit(ProductionUnitsuccess(
              employeeLoginSuccessModel: employeeLoginSuccessModel));
        } else if (employeeLoginSuccessModel.data.assiginedUnitId.type ==
            "Ib") {
          emit(IBsuccess(employeeLoginSuccessModel: employeeLoginSuccessModel));
        } else if (employeeLoginSuccessModel.data.assiginedUnitId.type ==
            "Ecoshop") {
          emit(Ecoshopsuccess(
              employeeLoginSuccessModel: employeeLoginSuccessModel));
        } else if (employeeLoginSuccessModel.data.assiginedUnitId.type ==
            "Stays") {
          emit(Stayssuccess(
              employeeLoginSuccessModel: employeeLoginSuccessModel));
        } else if (employeeLoginSuccessModel.data.assiginedUnitId.type ==
            "Entry Point") {
          emit(CheckPostSuccess(
              employeeLoginSuccessModel: employeeLoginSuccessModel));
        } else if (employeeLoginSuccessModel.data.assiginedUnitId.type ==
            "Reception") {
          emit(ReceptionSuccess(
              employeeLoginSuccessModel: employeeLoginSuccessModel));
        }
      } else if (employeeLoginSuccessModel.status == false) {
        emit(EmployeeloginError(error: employeeLoginSuccessModel.msg));
      }
    } else if (employeeloginModel.status == false) {
      emit(EmployeeloginError(error: employeeloginModel.msg));
    }
  }
}
