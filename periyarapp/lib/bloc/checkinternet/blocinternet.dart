import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/checkinternet/eventinternet.dart';
import 'package:parambikulam/bloc/checkinternet/stateinternet.dart';

class BlocInternet extends Bloc<EventInternet, StateInternet> {
  BlocInternet() : super(StateInternet()) {
    on<InternetFound>(_internetFound);
    on<NoInternetFound>(_noInternetFound);
    on<CheckingInternet>(_checkingInternet);
    on<RefreshEvent>(_refreshEvent);
  }
  Future<FutureOr<void>> _internetFound(
      InternetFound event, Emitter<StateInternet> emit) async {
    emit(FoundInternet());
  }

  Future<FutureOr<void>> _noInternetFound(
      NoInternetFound event, Emitter<StateInternet> emit) async {
    emit(NoInternet());
  }

  Future<FutureOr<void>> _checkingInternet(
      CheckingInternet event, Emitter<StateInternet> emit) async {
    emit(CheckingInternetState());
  }

  Future<FutureOr<void>> _refreshEvent(
      RefreshEvent event, Emitter<StateInternet> emit) async {
    emit(RefreshState());
  }

  // @override
  // Stream<StateInternet> mapEventToState(EventInternet event) async* {
  //   if (event is InternetFound) {
  //     yield FoundInternet();
  //   }

  //   if (event is NoInternetFound) {
  //     yield NoInternet();
  //   }
  //   if (event is CheckingInternet) {
  //     yield CheckingInternetState();
  //   }
  //     if (event is RefreshEvent) {
  //     yield RefreshState();
  //   }
  // }
}
