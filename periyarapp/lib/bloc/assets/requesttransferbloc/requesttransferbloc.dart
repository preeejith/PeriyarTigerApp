// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/requesttransferbloc/requesttransferevent.dart';
import 'package:parambikulam/bloc/assets/requesttransferbloc/requesttransferstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/requesttransfermodel.dart';
//////all ready waiting for up the server
class GetTransferRequestBloc
    extends Bloc<TransferRequestEvent, TransferRequestState> {
  GetTransferRequestBloc() : super(TransferRequestState()) {
    on<GetTransferRequest>(_getTransferRequest);
  }

  Future<FutureOr<void>> _getTransferRequest(
      GetTransferRequest event, Emitter<TransferRequestState> emit) async {
    emit(TransferRequesting());

    RequestTransferModel requestTransferModel;

    Map map = {
      "requestId": event.requestId,
       "AssetId": event.assetId,
        "quantity": event.quantity
    };

    requestTransferModel = await AuthRepository()
        .requesttransfer(url: '/asset/transfer/with/request', data: map);

    if (requestTransferModel.status == true) {
      emit(TransferRequestsuccess(  requestTransferModel:requestTransferModel  ));
    } else if (requestTransferModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
