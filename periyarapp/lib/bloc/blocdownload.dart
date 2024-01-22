import 'package:flutter_bloc/flutter_bloc.dart';

class BlocDownload extends Bloc<EventDownload, StateDownload> {
  BlocDownload() : super(StateDownload()) {
    on<DownloadStarted>(
      (event, emit) => emit(DownloadStartedState()),
    );
  }
}

class EventDownload {}

class DownloadStarted extends EventDownload {}

class StateDownload {}

class DownloadStartedState extends StateDownload {}
