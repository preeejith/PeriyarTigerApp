// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_eventdetailed.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_statedetailed.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmaindetailedmodel.dart';

class GetViewProductMainDetailedBloc
    extends Bloc<ViewProductMainDetailedEvent, ViewProductMainDetailedState> {
  GetViewProductMainDetailedBloc() : super(ViewProductMainDetailedState()) {
    on<GetViewProductMainDetailed>(_getViewProductMainDetailed);
  }

  Future<FutureOr<void>> _getViewProductMainDetailed(
      GetViewProductMainDetailed event,
      Emitter<ViewProductMainDetailedState> emit) async {
    emit(ViewProductMainDetaileding());

    ViewProductMainDetailedModel viewProductMainDetailedModel;

    Map map = {
      "productId": event.productId,
    };

    viewProductMainDetailedModel = await AuthRepository()
        .viewproductmaindetailed(url: '/product/detail', data: map);

    if (viewProductMainDetailedModel.status == true) {
      emit(ViewProductMainDetailedsuccess(
          viewProductMainDetailedModel: viewProductMainDetailedModel));
    } else if (viewProductMainDetailedModel.status == false) {
      emit(ViewProductMainDetailedError(
          error: viewProductMainDetailedModel.msg.toString()));
    }
  }
}
