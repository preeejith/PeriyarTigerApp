// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestdetailed_bloc/viewrequestdetailed_event.dart';
import 'package:parambikulam/bloc/assets/viewrequestdetailed_bloc/viewrequestdetailed_state.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/viewrequestdetailedmodel.dart';

class GetViewRequestDetailedBloc
    extends Bloc<ViewRequestDetailedEvent, ViewRequestDetailedState> {
  GetViewRequestDetailedBloc() : super(ViewRequestDetailedState()) {
    on<GetViewRequestDetailed>(_getViewRequestDetailed);
  }

  Future<FutureOr<void>> _getViewRequestDetailed(GetViewRequestDetailed event,
      Emitter<ViewRequestDetailedState> emit) async {
    emit(ViewingRequest());

    UnitRequestDetailedModel unitRequestDetailedModel;

    Map map = {"requestId": event.requestId, "requestType": event.requestType};
    unitRequestDetailedModel = await AuthRepository()
        .unitrequesteddetailed(url: '/request/detail/view', data: map);

    if (unitRequestDetailedModel.status == true) {
      emit(ViewRequestDetailedsuccess(
          unitRequestDetailedModel: unitRequestDetailedModel));
    } else if (unitRequestDetailedModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
