import 'package:equatable/equatable.dart';

class IcLogmainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetIcLogmain extends IcLogmainEvent {
  final dynamic data;

  GetIcLogmain({
    this.data,

  });
  @override
  List<Object> get props => [];
}

class FetchIcLogmain extends IcLogmainEvent {
  final dynamic data;

  FetchIcLogmain({this.data});
  @override
  List<Object> get props => [];
}

class RefreshIcLogmain extends IcLogmainEvent {
  final dynamic data;

  RefreshIcLogmain({this.data});
  @override
  List<Object> get props => [];
}
