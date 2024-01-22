// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestunit_bloc/viewrequest_event.dart';
import 'package:parambikulam/bloc/assets/viewrequestunit_bloc/viewrequest_state.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/viewrequestunitmodel.dart';

class GetViewRequestUnitBloc
    extends Bloc<ViewRequestUnitEvent, ViewRequestUnitState> {
  GetViewRequestUnitBloc() : super(ViewRequestUnitState()) {
    on<GetViewRequestUnit>(_getViewRequestUnit);
    // on<GetViewRequestUnit2>(_getViewRequestUnit2);
  }
  Future<FutureOr<void>> _getViewRequestUnit(
      GetViewRequestUnit event, Emitter<ViewRequestUnitState> emit) async {
    emit(ViewingRequest());

    ViewUnitsRequestModel viewUnitsRequestModel;

    Map map = {
      "zxc": event.unitId,
    };

    viewUnitsRequestModel = await AuthRepository()
        .viewunitrequest(url: '/view/all/request', data: map);

    if (viewUnitsRequestModel.status == true) {
      emit(
          ViewRequestUnitsuccess(viewUnitsRequestModel: viewUnitsRequestModel));
    } else if (viewUnitsRequestModel.status == false) {
      emit(Units2Error(error: viewUnitsRequestModel.msg));
    }
  }

  // Future<FutureOr<void>> _getViewRequestUnit2(
  //     GetViewRequestUnit2 event, Emitter<ViewRequestUnitState> emit) async {
  //   emit(ViewingRequest());

  //   ViewUnitsRequestModel viewUnitsRequestModel;

  //   Map map = {
  //     "requestType": event.requestType,
  //   };

  //   viewUnitsRequestModel = await AuthRepository()
  //       .viewunitrequest(url: '/view/all/request', data: map);

  //   if (viewUnitsRequestModel.status == true) {
  //     emit(
  //         ViewRequestUnitsuccess2(viewUnitsRequestModel: viewUnitsRequestModel));
  //   } else if (viewUnitsRequestModel.status == false) {
  //     emit(UnitsError(error: ''));
  //   }
  // }
}
