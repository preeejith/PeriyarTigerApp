import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/product/productevent.dart';
import 'package:parambikulam/bloc/product/productstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/product/productlistmodel.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetProductsEvent>(_getallproductsEvent);
  }

  Future<void> _getallproductsEvent(
      GetProductsEvent event, Emitter<ProductState> emit) async {
    emit(Checking());
    ProductListModel productListModel;

    productListModel =
        await AuthRepository().viewallproducts(url: '/products/getlist/unit');
    if (productListModel.status == true) {
      emit(GetProductSuccess(productListModel: productListModel));
    } else {
      emit(GetProductError());
    }
  }
}
