import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/selectorbloc/eventselector.dart';
import 'package:parambikulam/bloc/selectorbloc/stateselector.dart';

class BlocSelectorMain extends Bloc<EventSelector, StateSelector> {
  BlocSelectorMain() : super(BlocSelectorInitial());

  Stream<StateSelector> mapEventToState(EventSelector event) async* {}
}
