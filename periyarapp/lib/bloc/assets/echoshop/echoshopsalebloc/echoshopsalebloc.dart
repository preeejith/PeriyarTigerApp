// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoshopsalebloc/echoshopsaleevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoshopsalebloc/echoshopsalestate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echoshopsalesmodel.dart';

//////all ready waiting for up the server
///
class GetEchoShopSaleBloc extends Bloc<EchoShopSaleEvent, EchoShopSaleState> {
  GetEchoShopSaleBloc() : super(EchoShopSaleState()) {
    on<GetEchoShopSale>(_getEchoShopSale);
  }

  Future<FutureOr<void>> _getEchoShopSale(
      GetEchoShopSale event, Emitter<EchoShopSaleState> emit) async {
    emit(EchoShopSaleing());

    EchoShopSaleModel echoShopSaleModel;

    Map map = {
      "ticketNo": event.ticketNo,
      "isEmployee": event.isEmployee,
      "totalAmount": event.totalAmount,
      "items": [
          for (int i = 0; i < event.itemaddtocartlist.length; i++)
        {
          "productId": event.itemaddtocartlist[i].id,
          "quantity": event.itemaddtocartlist[i].quantity,
          "salesPrice": event.itemaddtocartlist[i].salesPrice
        }
      ]
    };

    echoShopSaleModel =
        await AuthRepository().echoshopsale(url: '/ecoshop/sale', data: map);

    if (echoShopSaleModel.status == true) {
      emit(EchoShopSalesuccess(echoShopSaleModel: echoShopSaleModel));
    } else if (echoShopSaleModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
