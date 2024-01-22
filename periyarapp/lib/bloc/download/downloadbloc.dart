import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/data/models/busmodel.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  BusModel busModel = BusModel();
  DownloadBloc() : super(DownloadState()) {
    on<DownloadOfflineData>(((event, emit) => emit(DownloadOfflineNow())));
    on<OfflineDataDownloaded>(
        ((event, emit) => emit(OfflineDataDownloadedState())));
    on<TermsAndConditionsAdded>(
        ((event, emit) => emit(TermsAndConditionsAddedState())));
    on<TicketsAdded>(((event, emit) => emit(TicketsAddedState())));
    on<SlotDataAdded>(((event, emit) => emit(SlotDataAddedState())));
    on<ProgramDataAdded>(((event, emit) => emit(ProgramDataAddedState())));
    on<CreateLocalDB>(((event, emit) => emit(CreateLocalDBState())));
    on<BusDataDownloaded>(((event, emit) => emit(BusDataAddedState())));
    //
    on<AddingTicketof>(((event, emit) =>
        emit(AddingTicketofState(ticketNumber: event.ticketNumber))));
  }
}

class DownloadEvent {}

class DownloadOfflineData extends DownloadEvent {}

class OfflineDataDownloaded extends DownloadEvent {}

class TermsAndConditionsAdded extends DownloadEvent {}

class TicketsAdded extends DownloadEvent {}

class SlotDataAdded extends DownloadEvent {}

class ProgramDataAdded extends DownloadEvent {}

class CreateLocalDB extends DownloadEvent {}

class AddingTicketof extends DownloadEvent {
  final String? ticketNumber;
  AddingTicketof({required this.ticketNumber});
}

class DownloadState {}

class DownloadOfflineNow extends DownloadState {}

class OfflineDataDownloadedState extends DownloadState {}

class TermsAndConditionsAddedState extends DownloadState {}

class TicketsAddedState extends DownloadState {}

class AddingTicketofState extends DownloadState {
  final String? ticketNumber;
  AddingTicketofState({required this.ticketNumber});
}

class SlotDataAddedState extends DownloadState {}

class BusDataAddedState extends DownloadState {}

class ProgramDataAddedState extends DownloadState {}

class CreateLocalDBState extends DownloadState {}

class BusDataNotDownloaded extends DownloadEvent {}

class BusDataDownloaded extends DownloadEvent {}
