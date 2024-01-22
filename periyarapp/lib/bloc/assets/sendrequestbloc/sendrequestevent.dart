import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/echoshoppages/sendrequestpage.dart';

class SendRequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSendRequest extends SendRequestEvent {
  final String? requestId;
  final String? remark;
  final List<AssetrequestModel> assetrequestcartlist;

  GetSendRequest(
      {this.requestId, this.remark, required this.assetrequestcartlist});
  @override
  List<Object> get props => [];
}

class FetchSendRequest extends SendRequestEvent {
  final dynamic data;

  FetchSendRequest(
      {this.data});
  @override
  List<Object> get props => [];
}
