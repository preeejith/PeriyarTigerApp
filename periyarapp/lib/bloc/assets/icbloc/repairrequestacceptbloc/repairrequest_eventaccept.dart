import 'package:equatable/equatable.dart';

class RepairRequestAcceptEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRepairRequestAccept extends RepairRequestAcceptEvent {
  final String? requestId;
  final String? assetId;
  final String? idno;

  GetRepairRequestAccept({
    this.requestId,
    this.assetId,
    this.idno,
  });
  @override
  List<Object> get props => [];
}
class FetchRepairRequestAccept extends RepairRequestAcceptEvent {
  dynamic data;

  FetchRepairRequestAccept({this.data});
  @override
  List<Object> get props => [];
}