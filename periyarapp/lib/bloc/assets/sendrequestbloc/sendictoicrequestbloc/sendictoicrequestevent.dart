import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/request/sendrequest_ic_toic.dart';

class SendRequestIctoIcEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSendRequestIctoIc extends SendRequestIctoIcEvent {
  final String? remark;
  final List<AssetrequestIcModel> asseticrequestcartlist;

  GetSendRequestIctoIc({this.remark, required this.asseticrequestcartlist});
  @override
  List<Object> get props => [];
}

class FetchSendRequestIctoIc extends SendRequestIctoIcEvent {
  final dynamic data;

  FetchSendRequestIctoIc({this.data});
  @override
  List<Object> get props => [];
}
