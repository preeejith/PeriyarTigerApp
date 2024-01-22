// import 'dart:async';


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:parambikulam/ui/assets/local/function/ibprogram_function.dart';



// class PendinOfflineBloc extends Bloc<EventPending, StatePending> {
//   PendinOfflineBloc() : super(StatePending()) {
//     on<GetOfflineData>(_getOfflineData);
//   }

//   Future<FutureOr<void>> _getOfflineData(
//       GetOfflineData event, Emitter<StatePending> emit) async {
//     emit(GettingOfflineData());
//     List items = await getAllSnaredata();
//     emit(OfflineDataReceived(items: items));
//   }
// }

// class EventPending {}

// class GetOfflineData extends EventPending {}

// class StatePending {}

// class GettingOfflineData extends StatePending {}

// class OfflineDataReceived extends StatePending {
//   final List? items;
//   OfflineDataReceived({this.items});
// }
