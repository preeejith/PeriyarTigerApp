import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/requestmainviewdetailedbloc/requestmainviewdetailedevent.dart';
import 'package:parambikulam/bloc/assets/new/requestmainviewdetailedbloc/requestmainviewdetailedstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';

class GetRequestMainDetailedBloc
    extends Bloc<RequestMainDetailedEvent, RequestMainDetailedState> {
  GetRequestMainDetailedBloc() : super(RequestMainDetailedState()) {
    on<GetRequestMainDetailed>(_getRequestMainDetailed);
  }

  Future<FutureOr<void>> _getRequestMainDetailed(GetRequestMainDetailed event,
      Emitter<RequestMainDetailedState> emit) async {
    emit(RequestMainDetaileding());

    RequestMainDetailedModel requestMainDetailedModel;
/////Stock updation //New updation//damage //repair
    Map map = {
      "requestId": event.requestId,
    };

    requestMainDetailedModel = await AuthRepository()
        .requestmaindetailed(url: '/details/request', data: map);

    if (requestMainDetailedModel.status == true) {
      emit(RequestMainDetailedsuccess(
          requestMainDetailedModel: requestMainDetailedModel));
    } else if (requestMainDetailedModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
