// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/rejectrequestbloc/rejectrequestevent.dart';
import 'package:parambikulam/bloc/assets/rejectrequestbloc/rejectrequeststate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/requestrejectmodel.dart';



//////all ready waiting for up the server




class GetRequestRejectBloc
    extends Bloc<RequestRejectEvent, RequestRejectState> {
  GetRequestRejectBloc() : super(RequestRejectState()) {
    on<GetRequestReject>(_getRequestReject);
  }

  Future<FutureOr<void>> _getRequestReject(
      GetRequestReject event, Emitter<RequestRejectState> emit) async {
    emit(Requestrejecting());

    RequestRejectModel requestRejectModel;

    Map map = {
      "requestId": event.requestId,
       "remark": event.remark
    };

    requestRejectModel = await AuthRepository()
        .rejectrequest(url: '/reject/request', data: map);

    if (requestRejectModel.status == true) {
      emit(RequestRejectsuccess(  requestRejectModel:requestRejectModel  ));
    } else if (requestRejectModel.status == false) {
      emit(RequestRejectError(error: ''));
    }
  }
}
