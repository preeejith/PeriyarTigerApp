import 'dart:async';
import 'dart:convert';
/////////
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeeevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeestate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/viewallemployeemodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class GetViewAllEmployeeBloc
    extends Bloc<ViewAllEmployeeEvent, ViewAllEmployeeState> {
  GetViewAllEmployeeBloc() : super(ViewAllEmployeeState()) {
    on<GetViewAllEmployeeEvent>(_getViewAllEmployeeEvent);
    on<FetchViewAllEmployeeEvent>(_fetchViewAllEmployeeEvent);
    on<RefreshViewAllEmployeeEvent>(_refreshViewAllEmployeeEvent);
  }

  Future<FutureOr<void>> _getViewAllEmployeeEvent(
      GetViewAllEmployeeEvent event, Emitter<ViewAllEmployeeState> emit) async {
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;
////
    Map map = {};
    response = await AuthRepository()
        .viewallemployee(url: '/get/all/employee', data: map);

    if (response['status'] == true) {
      await db.addICEmployeeListdata(jsonEncode(response));
      emit(EmployeeDownloadedSucces());
    }
  }

/////////
  Future<FutureOr<void>> _fetchViewAllEmployeeEvent(
      FetchViewAllEmployeeEvent event,
      Emitter<ViewAllEmployeeState> emit) async {
    ViewAllEmployeeModel viewAllEmployeeModel;
    DatabaseHelper? db = DatabaseHelper.instance;

    viewAllEmployeeModel = await db.getICEmployeeListDownloadData();
    emit(ViewAllEmployeeSuccess(viewAllEmployeeModel: viewAllEmployeeModel));
  }

  Future<FutureOr<void>> _refreshViewAllEmployeeEvent(
      RefreshViewAllEmployeeEvent event,
      Emitter<ViewAllEmployeeState> emit) async {
    emit(ViewAllEmployeeRefresh());
  }
}
