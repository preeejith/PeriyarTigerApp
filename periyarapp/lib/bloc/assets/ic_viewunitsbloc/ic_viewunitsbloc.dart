import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsevent.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class GetIcViewUnitsBloc extends Bloc<IcViewUnitsEvent, IcViewUnitsState> {
  GetIcViewUnitsBloc() : super(IcViewUnitsState()) {
    on<GetIcViewUnitsEvent>(_getIcViewUnitsEvent);
    on<FetchIcViewUnitsEvent>(_fetchIcViewUnitsEvent);
    on<RefreshIcViewUnitsEvent>(_refreshIcViewUnitsEvent);
  }

  Future<FutureOr<void>> _getIcViewUnitsEvent(
      GetIcViewUnitsEvent event, Emitter<IcViewUnitsState> emit) async {
    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;
/////////
    response = await AuthRepository().viewunits(url: '/view/all/units/ic');
///////
    if (response['status'] == true) {
      await db.addICUnitsListdata(jsonEncode(response));

      // Fluttertoast.showToast(msg: "Download Success");
    } else {}
  }

  Future<FutureOr<void>> _fetchIcViewUnitsEvent(
      FetchIcViewUnitsEvent event, Emitter<IcViewUnitsState> emit) async {
    IcViewUnitsModel icViewUnitsModel;

    DatabaseHelper? db = DatabaseHelper.instance;
    icViewUnitsModel = await db.getICUnitsListDownloadData();
    emit(IcViewUnitsSuccess(icViewUnitsModel: icViewUnitsModel));
  }

  Future<FutureOr<void>> _refreshIcViewUnitsEvent(
      RefreshIcViewUnitsEvent event, Emitter<IcViewUnitsState> emit) async {
    emit(Refreshingstate());
  }
}
