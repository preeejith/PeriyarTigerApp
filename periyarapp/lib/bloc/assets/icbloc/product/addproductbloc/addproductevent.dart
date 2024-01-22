import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/addproductmain.dart';


class AddProductMainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAddProductMain extends AddProductMainEvent {
  final ProductsModel productsModel;

  GetAddProductMain({
    required this.productsModel
  });
  @override
  List<Object> get props => [];
}
class FetchAddProductMain extends AddProductMainEvent {
  final dynamic data;

  FetchAddProductMain({
     this.data
  });
  @override
  List<Object> get props => [];
}
class RefreshAddProductMain extends AddProductMainEvent {
  final dynamic data;

  RefreshAddProductMain({
     this.data
  });
  @override
  List<Object> get props => [];
}