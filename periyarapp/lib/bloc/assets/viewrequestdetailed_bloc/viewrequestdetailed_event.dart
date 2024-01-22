import 'package:equatable/equatable.dart';

class ViewRequestDetailedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestDetailed extends ViewRequestDetailedEvent {
  final String? requestId;
  final String? requestType;
  GetViewRequestDetailed({
    this.requestId,
    this.requestType,
  });
  @override
  List<Object> get props => [];
}
