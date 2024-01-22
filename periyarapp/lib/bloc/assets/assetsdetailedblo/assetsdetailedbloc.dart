// ignore_for_file: avoid_print
//////all ready waiting for up the server
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/assets/assetsdetailedblo/assetsdetailedevent.dart';
import 'package:parambikulam/bloc/assets/assetsdetailedblo/assetsdetailedstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/assetsdetailedview.dart';

class GetViewAssetDetailedsBloc
    extends Bloc<ViewAssetDetailedsEvent, ViewAssetDetailedsState> {
  GetViewAssetDetailedsBloc() : super(ViewAssetDetailedsState()) {
    on<ViewAssetDetailedEvent>(_viewAssetDetailedEvent);
  }

  Future<FutureOr<void>> _viewAssetDetailedEvent(ViewAssetDetailedEvent event,
      Emitter<ViewAssetDetailedsState> emit) async {
    emit(AssetsView());

    AssetsDetailedViewModel assetsDetailedViewModel;

    Map map = {
      "assetId": event.assetId,
    };

    assetsDetailedViewModel = await AuthRepository()
        .assetsdetailedview(url: '/view/asset/inventory', data: map);

    if (assetsDetailedViewModel.status == true) {
      emit(ViewAssetDetailedssuccess(
          assetsDetailedViewModel: assetsDetailedViewModel));
    } else if (assetsDetailedViewModel.status == false) {
      emit(ViewAssetError(error: ''));
    }
  }
}
