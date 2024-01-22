///////delete the product
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeleteevent.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeletestate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/productdeletemodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetProductDeleteBloc
    extends Bloc<ProductDeleteEvent, ProductDeleteState> {
  GetProductDeleteBloc() : super(ProductDeleteState()) {
    on<GetProductDelete>(_getProductDelete);
  }

  Future<FutureOr<void>> _getProductDelete(
      GetProductDelete event, Emitter<ProductDeleteState> emit) async {
    emit(ProductDeleteing());
    List items59 = [];
    items59 = await getproductdeletedata();

    Productdeletemodel productdeletemodel;
    if (items59.isNotEmpty) {
      for (int i = 0; i < items59.length; i++) {
        if (items59[i]['added'] == "false") {
          Map map = {
            "productId": items59[i]['productid'],
          };

          productdeletemodel = await AuthRepository()
              .productdelete(url: '/delete/product/main', data: map);

          if (productdeletemodel.status == true) {
            await deleteinsertproductdeletedata(items59[i]['id']);

            emit(ProductDeletesuccess(productdeletemodel: productdeletemodel));
          } else if (productdeletemodel.status == false) {
            await deleteinsertproductdeletedata(items59[i]['id']);
            emit(ProductDeleteError(error: productdeletemodel.msg.toString()));
          }
        }
      }
    } else {}
  }
}
