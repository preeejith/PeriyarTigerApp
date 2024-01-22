import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestdetailedbloc/viewmyrequest_eventdetailed.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestdetailedbloc/viewmyrequest_statedetailed.dart';

import 'package:parambikulam/bloc/repositories/authrepository.dart';

import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestdetailedmodel.dart';
/////
class GetViewMyRequestDetailedBloc
    extends Bloc<ViewMyRequestDetailedEvent, ViewMyRequestDetailedState> {
  GetViewMyRequestDetailedBloc() : super(ViewMyRequestDetailedState()) {
    on<GetViewMyRequestDetailedEvent>(_getViewMyRequestDetailedEvent);
  }

  Future<FutureOr<void>> _getViewMyRequestDetailedEvent(
      GetViewMyRequestDetailedEvent event,
      Emitter<ViewMyRequestDetailedState> emit) async {
    emit(ReportGenerating());
    MyrequestDetailedModel myrequestDetailedModel;

    Map map = {
      "requestId": event.requestId,
    };

    myrequestDetailedModel = await AuthRepository()
        .myrequestdetailed(url: '/myrequests/details', data: map);
    if (myrequestDetailedModel.status == true) {
      emit(ViewMyRequestDetailedSuccess(
          myrequestDetailedModel: myrequestDetailedModel));
    } else {
      emit(ViewMyRequestDetailedError());
    }
  }
}
