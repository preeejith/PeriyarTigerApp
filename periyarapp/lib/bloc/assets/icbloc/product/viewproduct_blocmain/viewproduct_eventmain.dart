import 'package:equatable/equatable.dart';

 class ViewProductMainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewProductMainEvent extends ViewProductMainEvent {
  final dynamic data;

  GetViewProductMainEvent({this.data});
  @override
  List<Object> get props => [];
}
class GetProductsandDownload extends ViewProductMainEvent {
  
  @override
  List<Object> get props => [];
}

