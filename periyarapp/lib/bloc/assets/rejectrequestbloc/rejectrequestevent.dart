import 'package:equatable/equatable.dart';

class RequestRejectEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRequestReject extends RequestRejectEvent {
  final String? requestId;
  final String? remark;

  GetRequestReject({this.requestId, this.remark});
  @override
  List<Object> get props => [];
}
