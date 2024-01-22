import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

////
class EmployeelistOfflineBloc
    extends Bloc<EventEmployeeList, StateEmployeeList> {
  EmployeelistOfflineBloc() : super(StateEmployeeList()) {
    on<GetEmployeeListData>(_getEmployeeListData);
    on<RefreshEmployeeListData>(_refreshEmployeeListData);
    on<SearchEmployeeListData>(_searchEmployeeListData);
  }
///////
  Future<FutureOr<void>> _getEmployeeListData(
      GetEmployeeListData event, Emitter<StateEmployeeList> emit) async {
    // emit(GettingOfflineData());

    List items6 = await getAllEmployeeListdata();
    List items10 = await getAllDatedata();
    List items14 = await getAllDatedata3();
    List items9 = await getAllMarkedAttendancedata();
    List items13 = await getAllHaltDetailsdata();
    emit(EmployeeListing(
      items6: items6,
      items9: items9,
      items10: items10,
      items14: items14,
      items13: items13,
    ));
  }

/////
  ///search
  Future<FutureOr<void>> _searchEmployeeListData(
      SearchEmployeeListData event, Emitter<StateEmployeeList> emit) async {
    // emit(GettingOfflineData());
    String query = event.keyword.toString();

    List items6 = await getAllEmployeeListdata();
    List items10 = await getAllDatedata();
    List items14 = await getAllDatedata3();
    List items9 = await getAllMarkedAttendancedata();
    List items13 = await getAllHaltDetailsdata();
    List items06 = items6
        .where(
          (data) =>
              data['userName']!.toLowerCase().contains(query.toLowerCase()) ||
              data['userName']!.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    print(items06);
    query.isNotEmpty
        ? emit(SearchSuccess(
            items6: items6,
            items06: items06,
            items9: items9,
            items10: items10,
            items14: items14,
            items13: items13,
          ))
        : SizedBox();
    // emit(EmployeeListing(
    //   items6: items6,
    //   items9: items9,
    //   items10: items10,
    //   items14: items14,
    //   items13: items13,
    // ));
  }

  Future<FutureOr<void>> _refreshEmployeeListData(
      RefreshEmployeeListData event, Emitter<StateEmployeeList> emit) async {
    emit(GettingOfflineData());
  }
}

class EventEmployeeList {}

class GetEmployeeListData extends EventEmployeeList {}

class RefreshEmployeeListData extends EventEmployeeList {}

////search
class SearchEmployeeListData extends EventEmployeeList {
  final String? keyword;

  SearchEmployeeListData({
    this.keyword,
  });
 
  List<Object> get props => [];
}

class StateEmployeeList {}

class GettingOfflineData extends StateEmployeeList {}

///
class EmployeeListing extends StateEmployeeList {
  final List? items6;
  final List? items9;
  final List? items10;
  final List? items14;
  final List? items13;
  EmployeeListing(
      {this.items6, this.items10, this.items14, this.items9, this.items13});
}

class SearchSuccess extends StateEmployeeList {
  final List? items6;
  final List? items9;
  final List? items06;
  final List? items10;
  final List? items14;
  final List? items13;
  SearchSuccess(
      {this.items6,
      this.items06,
      this.items10,
      this.items14,
      this.items9,
      this.items13});
}
