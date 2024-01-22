import 'package:equatable/equatable.dart';

class EventUpdateGuest extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class DoDelete extends EventUpdateGuest {
  final String? personUniqueID;
  final int? index;
  final List? list;
  DoDelete({this.personUniqueID, this.index, this.list});
}

class RefreshStateOne extends EventUpdateGuest {}
