// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/unitdetailedviewbloc/unitdetailedviewevent.dart';
import 'package:parambikulam/bloc/assets/unitdetailedviewbloc/unitdetailedviewstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/unitsdetailedviewmodel.dart';

class GetUnitsDetailedViewBloc
    extends Bloc<UnitsDetailedViewEvent, UnitsDetailedViewState> {
  GetUnitsDetailedViewBloc() : super(UnitsDetailedViewState()) {
    on<GetUnitsDetailedView>(_getUnitsDetailedView);
  }

  Future<FutureOr<void>> _getUnitsDetailedView(
      GetUnitsDetailedView event, Emitter<UnitsDetailedViewState> emit) async {
    emit(UnitsViewing());

    UnitsDetailedViewModel unitsDetailedViewModel;

    Map map = {
      "unitId": event.unitId,
    };

    unitsDetailedViewModel = await AuthRepository()
        .unitsdetailedview(url: '/details/units', data: map);

    if (unitsDetailedViewModel.status == true) {
      emit(UnitsDetailedViewsuccess(
          unitsDetailedViewModel: unitsDetailedViewModel));
    } else if (unitsDetailedViewModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
