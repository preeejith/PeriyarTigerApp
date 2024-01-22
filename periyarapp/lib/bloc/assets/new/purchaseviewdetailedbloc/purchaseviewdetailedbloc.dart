// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewdetailedbloc/purchaseviewdetailedevent.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewdetailedbloc/purchaseviewdetailedstate.dart';


import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchasedetailed.dart';



class GetViewPurchaseOrderDetailedBloc
    extends Bloc<ViewPurchaseOrderDetailedEvent, ViewPurchaseOrderDetailedState> {
  GetViewPurchaseOrderDetailedBloc() : super(ViewPurchaseOrderDetailedState()) {
    on<GetViewPurchaseOrderDetailed>(_getViewPurchaseOrderDetailed);
  }

  Future<FutureOr<void>> _getViewPurchaseOrderDetailed(GetViewPurchaseOrderDetailed event,
      Emitter<ViewPurchaseOrderDetailedState> emit) async {
    emit(ViewPurchaseOrderDetaileding());

    ViewPurchaseDetailedModel viewPurchaseDetailedModel;

    Map map = {
      "purchaseId": event.purchaseId,
    };

    viewPurchaseDetailedModel = await AuthRepository()
        .viewpurchasedeatailed(url: '/purchase/details', data: map);

    if (viewPurchaseDetailedModel.status == true) {
      emit(ViewPurchaseOrderDetailedsuccess(
          viewPurchaseDetailedModel: viewPurchaseDetailedModel));
    } else if (viewPurchaseDetailedModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
