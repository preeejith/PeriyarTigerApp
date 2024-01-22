import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproduct_blocmain/viewproduct_eventmain.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproduct_blocmain/viewproduct_statemain.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmainmodel.dart';
class GetViewProductMainBloc
    extends Bloc<ViewProductMainEvent, ViewProductMainState> {
  GetViewProductMainBloc() : super(ViewProductMainState()) {
    on<GetViewProductMainEvent>(_getViewProductMainEvent);
  }
  Future<FutureOr<void>> _getViewProductMainEvent(
      GetViewProductMainEvent event, Emitter<ViewProductMainState> emit) async {
    emit(ViewingProduct());
    ViewProductMainModel viewProductMainModel;
    viewProductMainModel =
        await AuthRepository().viewproductmain(url: '/view/all/products/v3');
    if (viewProductMainModel.status == true) {
      emit(ViewProductMainSuccess(viewProductMainModel: viewProductMainModel));
    } else {
      emit(ViewProductMainError());
    }
  }  
}
