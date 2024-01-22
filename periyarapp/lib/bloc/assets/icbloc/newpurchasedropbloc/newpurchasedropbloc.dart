import 'dart:async';
import 'dart:convert';
////for New purchase
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/newpurchasedropmodel.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

///////
class GetNewPurchasedropBloc
    extends Bloc<NewPurchasedropEvent, NewPurchasedropState> {
  GetNewPurchasedropBloc() : super(NewPurchasedropState()) {
    on<GetNewPurchasedropEvent>(_getNewPurchasedropEvent);

    on<FetchNewPurchasedropEvent>(_fetchNewPurchasedropEvent);
  }

  Future<FutureOr<void>> _getNewPurchasedropEvent(
      GetNewPurchasedropEvent event, Emitter<NewPurchasedropState> emit) async {
    emit(Checking());

    dynamic response;
    DatabaseHelper? db = DatabaseHelper.instance;

    response = await AuthRepository().newpurchasedrop(url: '/unit/inventory');
    if (response['status'] == true) {
      await db.addNewPurDropViewData(jsonEncode(response));
    } else {}
  }

  Future<FutureOr<void>> _fetchNewPurchasedropEvent(
      FetchNewPurchasedropEvent event,
      Emitter<NewPurchasedropState> emit) async {
    emit(Checking());
    NewPurchaseDropModel newPurchaseDropModel;

    DatabaseHelper? db = DatabaseHelper.instance;

    newPurchaseDropModel = await db.getNewPurDropDownloadData();
    emit(NewPurchasedropSuccess(newPurchaseDropModel: newPurchaseDropModel));
  }
}
