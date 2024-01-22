// ignore_for_file: avoid_print
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/new/addproductbloc/addproductevent.dart';
import 'package:parambikulam/bloc/assets/new/addproductbloc/addproductstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';

//////
class GetAddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  GetAddProductBloc() : super(AddProductState()) {
    on<GetAddProduct>(_getAddProduct);
    on<AddProduct>(((event, emit) {
      emit(OneAdd());
    }));
    on<BackEvent>(((event, emit) => emit(OneClear())));
  }

  Future<FutureOr<void>> _getAddProduct(
      GetAddProduct event, Emitter<AddProductState> emit) async {
    emit(AddProducting());

    AddAssetMainModel addAssetMainModel;

    Map map = {
      // "purchaseId": event.purchaseId,
      // "totalAmount": event.totalAmount,
      // "discount": event.discount,
      // "product": [
      //   for (int i = 0; i < event.addproductslist.length; i++)
      //     {
      //       "name": event.addproductslist[i].productname,
      //       "productId": event.addproductslist[i].productid,
      //       "discount": event.addproductslist[i].discount,
      //            "price": event.addproductslist[i].price,
      //       "purchaseAmount": event.addproductslist[i].purchaseamount,
      //       "quantity": event.addproductslist[i].quantity,
      //       "description": event.addproductslist[i].description,
      //     }
      // ]
    };

    addAssetMainModel =
        await AuthRepository().addproduct(url: '/add/products', data: map);

    if (addAssetMainModel.status == true) {
      emit(AddProductsuccess(addAssetMainModel: addAssetMainModel));
    } else if (addAssetMainModel.status == false) {
      emit(UnitsError(error: ''));
    }
  }
}
