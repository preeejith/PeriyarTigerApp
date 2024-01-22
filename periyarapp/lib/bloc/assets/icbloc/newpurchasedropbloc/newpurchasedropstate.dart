
import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/new/newpurchasedropmodel.dart';





 class NewPurchasedropState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewPurchasedropInitial extends NewPurchasedropState {}

class Checking extends NewPurchasedropState {}

class NewPurchasedropSuccess extends NewPurchasedropState {
  final NewPurchaseDropModel newPurchaseDropModel;
  NewPurchasedropSuccess({required this.newPurchaseDropModel});
  @override
  List<Object> get props => [];
}

class NewPurchasedropEmpty extends NewPurchasedropState {
  @override
  List<Object> get props => [];
}

class NewPurchasedropError extends NewPurchasedropState {
  @override
  List<Object> get props => [];
}
