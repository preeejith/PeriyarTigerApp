// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/assetstransfermainbloc/assetstransfermainevent.dart';
import 'package:parambikulam/bloc/assets/new/assetstransfermainbloc/assetstransfermainstate.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/assetstransfermainmodel.dart';

class GetAssetsTransferMainBloc
    extends Bloc<AssetsTransferMainEvent, AssetsTransferMainState> {
  GetAssetsTransferMainBloc() : super(AssetsTransferMainState()) {
    on<GetAssetsTransferMain>(_getAssetsTransferMain);
  }

  Future<FutureOr<void>> _getAssetsTransferMain(GetAssetsTransferMain event,
      Emitter<AssetsTransferMainState> emit) async {
    emit(AssetsTransferMaining());

    AssetsTrasnferMainModel assetsTrasnferMainModel;

    Map map = {
      "purchaseId": event.purchaseId,
      "transferedtoId": event.transferedtoId,

      // "assets": [
      //   for (int i = 0; i < event.AssetsTransferMainslist.length; i++)
      //     {
      //       "assetId": event.AssetsTransferMainslist[i].productname,
      //       "quantity": event.AssetsTransferMainslist[i].productid,
      //       "remark": event.AssetsTransferMainslist[i].discount,

      //     }
      // ]
    };

    assetsTrasnferMainModel = await AuthRepository()
        .assetstransfermain(url: '/transfer/assetv1', data: map);

    if (assetsTrasnferMainModel.status == true) {
      emit(AssetsTransferMainsuccess(

          // assetsTrasnferMainModel: assetsTrasnferMainModel

          ));
    } else if (assetsTrasnferMainModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
