import 'package:equatable/equatable.dart';

class EventPTicket extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PrintTicket extends EventPTicket {
  final String? ticketId;
  final bool? isOpen;
  PrintTicket({this.ticketId, this.isOpen});
}
