import 'package:equatable/equatable.dart';

//new
class ViewMyRequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewMyRequestEvent extends ViewMyRequestEvent {
  final dynamic data;

  GetViewMyRequestEvent({this.data});
  @override
  List<Object> get props => [];
}


class FetchViewMyRequestEvent extends ViewMyRequestEvent {
  final dynamic data;

  FetchViewMyRequestEvent({this.data});
  @override
  List<Object> get props => [];
}

class RefreshViewMyRequestEvent extends ViewMyRequestEvent {
  final dynamic data;

  RefreshViewMyRequestEvent({this.data});
  @override
  List<Object> get props => [];
}

class OnlinedataViewMyRequestEvent extends ViewMyRequestEvent {
  final dynamic data;

  OnlinedataViewMyRequestEvent({this.data});
  @override
  List<Object> get props => [];
}