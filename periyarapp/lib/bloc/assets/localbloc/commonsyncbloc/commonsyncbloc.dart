import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class CommonDatauploadBloc
    extends Bloc<EventCommonDataUpload, StateCommonDataUpload> {
  CommonDatauploadBloc() : super(StateCommonDataUpload()) {
    on<GetCommonDataUpload>(_getCommonDataUpload);
  }
//
  Future<FutureOr<void>> _getCommonDataUpload(
      GetCommonDataUpload event, Emitter<StateCommonDataUpload> emit) async {
    emit(GettingCommonData());
/////reservation
    List items4 = await getAllReservationdata();
    emit(CommondataUploaded(
      items4: items4,
    ));
  }
}

class EventCommonDataUpload {}

class GetCommonDataUpload extends EventCommonDataUpload {}

class StateCommonDataUpload {}

class GettingCommonData extends StateCommonDataUpload {}

class CommondataUploaded extends StateCommonDataUpload {
  final List? items4;
  CommondataUploaded({this.items4});
}
