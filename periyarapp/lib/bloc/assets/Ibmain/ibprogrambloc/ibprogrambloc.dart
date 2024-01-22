/////ui Not completed
/////
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogramevent.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogramstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibprogramsmodel.dart';

///new needed
/////////
class GetIBprogramBloc extends Bloc<IBprogramEvent, IBprogramState> {
  GetIBprogramBloc() : super(IBprogramState()) {
    on<GetIBprogramEvent>(_getIBprogramEvent);
  }

  Future<FutureOr<void>> _getIBprogramEvent(
      GetIBprogramEvent event, Emitter<IBprogramState> emit) async {
    emit(IBprogram());
    IbProgramsModel ibProgramsModel;

    ibProgramsModel =
      
        await AuthRepository().ibprogram(url: '/booking/ib/getslots/app');
    if (ibProgramsModel.status == true) { 
      emit(IBprogramSuccess(ibProgramsModel: ibProgramsModel));
    } else {
      emit(IBprogramError());
    }
  }
}
