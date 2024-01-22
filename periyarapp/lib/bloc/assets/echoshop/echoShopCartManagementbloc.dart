import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class GetEchoShopCartManagementBloc
    extends Bloc<EchoShopCartManagementEvent, EchoShopCartManagementState> {
  List<Map>? cartData = [];
  DatabaseHelper db = DatabaseHelper.instance;
  GetEchoShopCartManagementBloc() : super(EchoShopCartManagementState()) {
    on<PlaceOrder>(_getEcoShopPlaceOrder);
    on<ViewCart>(_viewCart);
  }

  Future<FutureOr<void>> _getEcoShopPlaceOrder(
      PlaceOrder event, Emitter<EchoShopCartManagementState> emit) async {
    await db.addPlaceorderData(jsonEncode(event.data));
    
     print( await db.getPlaceorderData());

    emit(ViewingCartManagement());
  }
  

  Future<FutureOr<void>> _viewCart(
      ViewCart event, Emitter<EchoShopCartManagementState> emit) async {
    emit(EchoShopCartView(cartData: cartData));
  }
}

//events

class EchoShopCartManagementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceOrder extends EchoShopCartManagementEvent {
  @override
  List<Object> get props => [];
  final Map? data;
  PlaceOrder({this.data});
}

class ViewCart extends EchoShopCartManagementEvent {
  @override
  List<Object> get props => [];
}
//states

class EchoShopCartManagementState extends Equatable {
  @override
  List<Object> get props => [];
}

class EchoShopCartManagementInitial extends EchoShopCartManagementState {}

class ViewingCartManagement extends EchoShopCartManagementState {}

class EchoShopCartManagementSuccess extends EchoShopCartManagementState {
  @override
  List<Object> get props => [];
}

class EchoShopCartManagementEmpty extends EchoShopCartManagementState {
  @override
  List<Object> get props => [];
}

class EchoShopCartManagementError extends EchoShopCartManagementState {
  @override
  List<Object> get props => [];
}

class EchoShopCartView extends EchoShopCartManagementState {
  @override
  List<Object> get props => [];
  final List<Map>? cartData;
  final double? totalAmount;
  EchoShopCartView({this.cartData, this.totalAmount});
}
