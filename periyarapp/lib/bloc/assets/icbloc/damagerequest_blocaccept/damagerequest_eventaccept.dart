import 'package:equatable/equatable.dart';

class DamageRequestAcceptEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDamageRequestAccept extends DamageRequestAcceptEvent {
  final String? requestId;
  final String? statusmain;
  final String? assetId;
  final String? remark;
  final String? idno;

  GetDamageRequestAccept({
    this.requestId,
    this.statusmain,
    this.assetId,
    this.idno,
    this.remark,
  });
  @override
  List<Object> get props => [];
}

class FetchDamageRequestAccept extends DamageRequestAcceptEvent {
  dynamic data;

  FetchDamageRequestAccept({this.data});
  @override
  List<Object> get props => [];
}
