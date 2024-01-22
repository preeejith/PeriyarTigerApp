import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportevent.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/attendance/halt/haltreportmodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetReportHaltBloc extends Bloc<ReportHaltEvent, ReportHaltState> {
  GetReportHaltBloc() : super(ReportHaltState()) {
    on<ReportHaltEvent>(_reportHaltEvent);
  }

  Future<FutureOr<void>> _reportHaltEvent(
      ReportHaltEvent event, Emitter<ReportHaltState> emit) async {
    emit(AssetsView());

    HaltReportModel haltReportModel;

    Map map = {"from": "", "to": "", "empId": "", "date": ""};

    haltReportModel =
        await AuthRepository().haltreport(url: '/halt/report', data: map);

    if (haltReportModel.status == true) {
      for (int i = 0; i < haltReportModel.data!.length; i++) {
        final dateid = haltReportModel.data![i].id == null
            ? ""
            : haltReportModel.data![i].id;

        {
          for (int j = 0; j < haltReportModel.data![i].halt!.length; j++) {
            final haltid = haltReportModel.data![i].halt![j].id == null
                ? ""
                : haltReportModel.data![i].halt![j].id;
            final empid = haltReportModel.data![i].halt![j].empId!.id == null
                ? ""
                : haltReportModel.data![i].halt![j].empId!.id;
            final phoneNumber =
                haltReportModel.data![i].halt![j].empId!.phoneNumber == null
                    ? ""
                    : haltReportModel.data![i].halt![j].empId!.phoneNumber;
            final role = haltReportModel.data![i].halt![j].empId!.role == null
                ? ""
                : haltReportModel.data![i].halt![j].empId!.role;
            final userName =
                haltReportModel.data![i].halt![j].empId!.userName == null
                    ? ""
                    : haltReportModel.data![i].halt![j].empId!.userName;
            final dob = haltReportModel.data![i].halt![j].empId!.dob == null
                ? ""
                : haltReportModel.data![i].halt![j].empId!.dob;

            final gender =
                haltReportModel.data![i].halt![j].empId!.gender == null
                    ? ""
                    : haltReportModel.data![i].halt![j].empId!.gender;
            final assignedUnitId =
                haltReportModel.data![i].halt![j].empId!.assiginedUnitId == null
                    ? ""
                    : haltReportModel.data![i].halt![j].empId!.assiginedUnitId;

            final assingedTo =
                haltReportModel.data![i].halt![j].empId!.assignedTo == null
                    ? ""
                    : haltReportModel.data![i].halt![j].empId!.assignedTo;
            final haltDate = haltReportModel.data![i].halt![j].haltDate == null
                ? ""
                : haltReportModel.data![i].halt![j].haltDate;

            if (empid!.isEmpty) {
              return null;
            } else {
              Map data = {
                'dateid': dateid,
                'haltid': haltid,
                'empid': empid,
                'phoneNumber': phoneNumber,
                'role': role,
                'userName': userName,
                'dob': dob,
                'gender': gender,
                'assignedUnitId': assignedUnitId,
                'assingedTo': assingedTo,
                'haltDate': haltDate,
                'count': "1",
              };
              print(data);
              haltreport(data);
            }
          }
        }
      }

      emit(ReportHaltsuccess(haltReportModel: haltReportModel));
    } else if (haltReportModel.status == false) {
      emit(ReportHaltError(error: ''));
    }
  }
}
