import 'package:equatable/equatable.dart';





class ProductMainEditEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductMainEdit extends ProductMainEditEvent {
  final dynamic data;
   

  GetProductMainEdit({
     this.data
  });
  @override
  List<Object> get props => [];
}
class FetchProductMainEdit extends ProductMainEditEvent {
  final dynamic data;
   

  FetchProductMainEdit({
     this.data
  });
  @override
  List<Object> get props => [];
}