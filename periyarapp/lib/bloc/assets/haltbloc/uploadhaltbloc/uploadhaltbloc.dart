// ignore_for_file: avoid_print
//////all ready waiting for up the server
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltevent.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/attendance/halt/haltuploadmodel.dart';

class GetUploadHaltBloc extends Bloc<UploadHaltEvent, UploadHaltState> {
  GetUploadHaltBloc() : super(UploadHaltState()) {
    on<UploadHaltEvent>(_uploadHaltEvent);
  }

  Future<FutureOr<void>> _uploadHaltEvent(
      UploadHaltEvent event, Emitter<UploadHaltState> emit) async {
    emit(AssetsView());

    HaltUploadModel haltUploadModel;

    Map map = {
      "date": event.halt2uploadlist.length != 0
          ? event.halt2uploadlist[0].date.toString()
          : "",
      "halt": [
        for (int i = 0; i < event.halt2uploadlist.length; i++)
          {
            "empId": event.halt2uploadlist[i].empId,
          }
      ]
    };

    haltUploadModel =
        await AuthRepository().haltupload(url: '/employee/add/halt', data: map);

    if (haltUploadModel.status == true) {
      emit(UploadHaltsuccess(haltUploadModel: haltUploadModel));
    } else if (haltUploadModel.status == false) {
      emit(UploadHaltError(error: haltUploadModel.msg.toString()));
    }
  }
}
