// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestunittype_bloc.dart/viewrequestunittype_event.dart';
import 'package:parambikulam/bloc/assets/viewrequestunittype_bloc.dart/viewrequestunittype_state.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/viewrequestunitmodel.dart';


class GetViewRequestUnittypeBloc
    extends Bloc<ViewRequestUnittypeEvent, ViewRequestUnittypeState> {
  GetViewRequestUnittypeBloc() : super(ViewRequestUnittypeState()) {
    on<GetViewRequestUnittype>(_getViewRequestUnittype);
    //  on<GetViewRequestUnittype2>(_getViewRequestUnittype2);
  }

  Future<FutureOr<void>> _getViewRequestUnittype(
      GetViewRequestUnittype event, Emitter<ViewRequestUnittypeState> emit) async {
    emit(ViewingRequest());

    ViewUnitsRequestModel viewUnitsRequestModel;

      Map map = {
      "requestType": event.requestType,
    };

    viewUnitsRequestModel = await AuthRepository()
        .viewunitrequest(url: '/view/all/request', data: map);

    if (viewUnitsRequestModel.status == true) {
      emit(
          ViewRequestUnittypesuccess(viewUnitsRequestModel: viewUnitsRequestModel));
    } else if (viewUnitsRequestModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }

 
}
