import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/sendrequest/sendstockupdationrequest.dart';

class RequestUpdationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRequestUpdation extends RequestUpdationEvent {
  final String? requestId;
  final String? description;
  final List<Assetrequest2Model> assetrequestcartlist;

  GetRequestUpdation(
      {this.requestId, this.description, required this.assetrequestcartlist});
  @override
  List<Object> get props => [];
}

class FetchRequestUpdation extends RequestUpdationEvent {
  final dynamic data;

  FetchRequestUpdation(
      {this.data});
  @override
  List<Object> get props => [];
}
