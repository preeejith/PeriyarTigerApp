import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/viewrequestmainstockupdation.dart';



class TransferStockUpdationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransferStockUpdation extends TransferStockUpdationEvent {
  final String? requestId;
  final String? transferedtoId;

  final List<RequestModel2> requestlist2;

  GetTransferStockUpdation(
      {this.requestId, this.transferedtoId, required this.requestlist2});
  @override
  List<Object> get props => [];
}
class FetchTransferStockUpdation extends TransferStockUpdationEvent {
  final dynamic data;


  FetchTransferStockUpdation(
      {this.data});
  @override
  List<Object> get props => [];
}


class RefreshTransferStockUpdation extends TransferStockUpdationEvent {
  final dynamic data;


  RefreshTransferStockUpdation(
      {this.data});
  @override
  List<Object> get props => [];
}