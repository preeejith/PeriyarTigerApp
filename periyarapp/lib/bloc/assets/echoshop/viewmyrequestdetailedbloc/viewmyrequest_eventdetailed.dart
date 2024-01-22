import 'package:equatable/equatable.dart';

 class ViewMyRequestDetailedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewMyRequestDetailedEvent extends ViewMyRequestDetailedEvent {
final String? requestId;


  GetViewMyRequestDetailedEvent({this.requestId});
  @override
  List<Object> get props => [];
}
