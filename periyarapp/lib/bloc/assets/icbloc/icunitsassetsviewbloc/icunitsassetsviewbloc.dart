// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/icunitsassetsviewbloc/icunitsassetsviewevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/icunitsassetsviewbloc/icunitsassetsviewstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/icunitassetsviewmodel.dart';

class GetIcUnitsassetsviewBloc
    extends Bloc<IcUnitsassetsviewEvent, IcUnitsassetsviewState> {
  GetIcUnitsassetsviewBloc() : super(IcUnitsassetsviewState()) {
    on<GetIcUnitsassetsview>(_getIcUnitsassetsview);
  }

  Future<FutureOr<void>> _getIcUnitsassetsview(
      GetIcUnitsassetsview event, Emitter<IcUnitsassetsviewState> emit) async {
    emit(IcUnitsassetsviewing());

    IcUnitAssetsViewModel icUnitAssetsViewModel;

    Map map = {"unitId": event.unitId};

    icUnitAssetsViewModel = await AuthRepository()
        .icunitsassetsview(url: '/ic/view/unit/inventory', data: map);

    if (icUnitAssetsViewModel.status == true) {
      emit(IcUnitsassetsviewsuccess(
          icUnitAssetsViewModel: icUnitAssetsViewModel));
    } else if (icUnitAssetsViewModel.status == false) {
      emit(IcUnitsassetsviewError(error: icUnitAssetsViewModel.msg.toString()));
    }
  }
}
