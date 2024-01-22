// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/addassetsbloc/addassetsevent.dart';
import 'package:parambikulam/bloc/assets/addassetsbloc/addassetsstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/addassetsmodel.dart';

class GetViewAssetsBloc extends Bloc<ViewAssetsEvent, ViewAssetsState> {
  GetViewAssetsBloc() : super(ViewAssetsState()) {
    on<ViewAssetEvent>(_viewAssetEvent);
  }

  Future<FutureOr<void>> _viewAssetEvent(
      ViewAssetEvent event, Emitter<ViewAssetsState> emit) async {
    emit(Logginging());

    AddAssetsModel addAssetsModel;

    Map map = {
      "name": event.name,
      "productType": event.productType,
      "description": event.description,
      "quantity": event.quantity,
      "salePrice": event.salePrice,
      "price": event.price,
      "discount": event.discount,
      "remark": event.remark,
    };

    addAssetsModel =
        await AuthRepository().addassets(url: '/add/asset/ic', data: map);

    if (addAssetsModel.status == true) {
      emit(ViewAssetssuccess());
    } else if (addAssetsModel.status == false) {
      emit(ViewAsseError(error: ''));
    }
  }
}
