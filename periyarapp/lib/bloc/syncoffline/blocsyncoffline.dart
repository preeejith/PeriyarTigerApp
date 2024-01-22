import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/syncoffline/eventsyncoffline.dart';
import 'package:parambikulam/bloc/syncoffline/statesyncoffline.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/utils/helper.dart';
import 'package:parambikulam/utils/serverhelper.dart';

class BlocSyncOffline extends Bloc<EventSyncOffline, StateSyncOffline> {
  DatabaseHelper? db = DatabaseHelper.instance;
  int busLength = 0;
  BlocSyncOffline() : super(StateSyncOffline()) {
    on<UploadFailedData>(_uploadFailedData);
    on<UploadEventInitial>(_uploadEventInitial);
    on<DataFound>(_dataFound);
    on<UploadingBusData>(((event, emit) => emit(BusDataUploading())));
    //BusDataUploaded
    on<BusDataUploaded>(((event, emit) => emit(BusDataUploadedState())));
    on<DataNotFound>(_dataNotFound);
    on<UploadingInitiated>(_uploadingInitiated);
    on<UploadingFinished>(_uploadingFinished);
    on<UploadingNotFinished>(_uploadingNotFinished);
    on<NoInternet>(_noInternet);
    on<GetFailedData>(_getFailedData);
  }
  Future<FutureOr<void>> _uploadEventInitial(
      UploadEventInitial event, Emitter<StateSyncOffline> emit) async {
    emit(CheckingSync());
  }

  Future<FutureOr<void>> _dataFound(
      DataFound event, Emitter<StateSyncOffline> emit) async {
    busLength = event.busUploadLength!;
    emit(
        DataFoundState(length: event.length, failedLength: event.failedLength));
  }

  Future<FutureOr<void>> _dataNotFound(
      DataNotFound event, Emitter<StateSyncOffline> emit) async {
    emit(DataNotFoundState());
  }

  Future<FutureOr<void>> _uploadingInitiated(
      UploadingInitiated event, Emitter<StateSyncOffline> emit) async {
    emit(CheckingSync());
  }

  Future<FutureOr<void>> _uploadingFinished(
      UploadingFinished event, Emitter<StateSyncOffline> emit) async {
    emit(CheckingSync());
  }

  Future<FutureOr<void>> _uploadingNotFinished(
      UploadingNotFinished event, Emitter<StateSyncOffline> emit) async {
    // emit(CheckingSync());
  }

  Future<FutureOr<void>> _noInternet(
      NoInternet event, Emitter<StateSyncOffline> emit) async {
    emit(CheckingSync());
  }

  Future<FutureOr<void>> _getFailedData(
      GetFailedData event, Emitter<StateSyncOffline> emit) async {
    emit(ShowFailedData(finalList: event.finalList));
  }

  // @override
  // Stream<StateSyncOffline> mapEventToState(EventSyncOffline event) async* {
  //   if (event is UploadEventInitial) {
  //     yield CheckingSync();
  //   }
  //   if (event is DataFound) {
  //     yield DataFoundState(
  //         length: event.length, failedLength: event.failedLength);
  //   }
  //   if (event is DataNotFound) {
  //     yield DataNotFoundState();
  //   }

  //   if (event is UploadingInitiated) {
  //     yield UploadingData();
  //   }
  //   if (event is UploadingFinished) {
  //     yield UploadingFinishedState();
  //   }
  //   if (event is UploadingNotFinished) {
  //     yield UploadingNotFinishedState(length: event.length);
  //   }
  //   if (event is NoInternet) {
  //     yield NoInternetState();
  //   }
  //   if (event is GetFailedData) {
  //     yield ShowFailedData(finalList: event.finalList);
  //   }
  // }

  FutureOr<void> _uploadFailedData(
      UploadFailedData event, Emitter<StateSyncOffline> emit) async {
    var url = '/sync/error';
    for (int i = 0; i < event.finalList!.length; i++) {
      Map data = {
        "ticketId": event.finalList![i]['ticketId'],
        "errorReason": event.finalList![i]['reason'],
        "data": event.finalList!.toString(),
      };
      print(data);
      dynamic response = await ServerHelper.post(url, data);
      if (response['status']) {
        Helper.centerToast("Uploaded");
        print("Failed data uploaded");
        await deleteFromTable(event.finalList![i]['id']);
      } else {
        print("Failed data not uploaded");
      }
    }
  }

  deleteFromTable(id) async {
    var deleteResult = await db!.deleteFromBookings(int.parse(id.toString()));
    print("deleteResult $deleteResult");
    if (deleteResult == 1) {
      Fluttertoast.showToast(msg: "Deleted");
    } else {
      Fluttertoast.showToast(msg: "Deletion Failed");
    }
  }

  FutureOr<void> _uploadBusData(
      UploadingBusData event, Emitter<StateSyncOffline> emit) {}
}
