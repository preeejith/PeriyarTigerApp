import 'package:equatable/equatable.dart';

 class ViewRequestMainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestMainEvent extends ViewRequestMainEvent {
final String? filters;

  GetViewRequestMainEvent({    this.filters,});
  @override
  List<Object> get props => [];
}

class FetchViewRequestMainEvent extends ViewRequestMainEvent {
final String? filters;

  FetchViewRequestMainEvent({    this.filters,});
  @override
  List<Object> get props => [];
}
class RefreshViewRequestMainEvent extends ViewRequestMainEvent {
final dynamic data;

  RefreshViewRequestMainEvent({    this.data,});
  @override
  List<Object> get props => [];
}

class FetchofflineRequestMainEvent extends ViewRequestMainEvent {
final dynamic data;

  FetchofflineRequestMainEvent({    this.data,});
  @override
  List<Object> get props => [];
}


class GetofflineRequestMainEvent extends ViewRequestMainEvent {
final dynamic data;

  GetofflineRequestMainEvent({    this.data,});
  @override
  List<Object> get props => [];
}