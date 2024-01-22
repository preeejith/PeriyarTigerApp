import 'package:equatable/equatable.dart';

 class NewPurchasedropEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNewPurchasedropEvent extends NewPurchasedropEvent {
  final dynamic data;

  GetNewPurchasedropEvent({this.data});
  @override
  List<Object> get props => [];
}
class FetchNewPurchasedropEvent extends NewPurchasedropEvent {
  final dynamic data;

  FetchNewPurchasedropEvent({this.data});
  @override
  List<Object> get props => [];
}