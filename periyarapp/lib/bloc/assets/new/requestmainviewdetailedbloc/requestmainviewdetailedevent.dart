import 'package:equatable/equatable.dart';

class RequestMainDetailedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetRequestMainDetailed extends RequestMainDetailedEvent {
  final String? requestId;

  GetRequestMainDetailed({
    this.requestId,
  });
  @override
  List<Object> get props => [];
}
