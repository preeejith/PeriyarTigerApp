// ignore_for_file: avoid_print
///////////
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/attendancereportbloc/attendancereportevent.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/attendancereportbloc/attendancereportstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/attendance/attendancereportmodel.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class GetAttendanceReportBloc
    extends Bloc<AttendanceReportEvent, AttendanceReportState> {
  GetAttendanceReportBloc() : super(AttendanceReportState()) {
    on<GetAttendanceReport>(_getAttendanceReport);
  }

  Future<FutureOr<void>> _getAttendanceReport(
      GetAttendanceReport event, Emitter<AttendanceReportState> emit) async {
    emit(AttendanceReporting());

    AttendanceReportModel attendanceReportModel;

    Map map = {
      "from": "",
      "to": "",
      "empId": "",
      "date": "",
    };

    attendanceReportModel = await AuthRepository()
        .attendancereport(url: '/attandance/report', data: map);

    if (attendanceReportModel.status == true) {
      for (int i = 0; i < attendanceReportModel.data!.length; i++) {
        final dateid = attendanceReportModel.data![i].id == null
            ? ""
            : attendanceReportModel.data![i].id;

        for (int j = 0;
            j < attendanceReportModel.data![i].attandance!.length;
            j++) {
          final attendanceid =
              attendanceReportModel.data![i].attandance![j].id == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].id;
          final isPresent =
              attendanceReportModel.data![i].attandance![j].isPresent == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].isPresent;
          final leaveType =
              attendanceReportModel.data![i].attandance![j].leaveType == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].leaveType;

          final isSpecialDay =
              attendanceReportModel.data![i].attandance![j].isSpecialDay == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].isSpecialDay;
          final empId =
              attendanceReportModel.data![i].attandance![j].empId == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].empId!.id;
          final phoneNumber =
              attendanceReportModel.data![i].attandance![j].empId == null
                  ? ""
                  : attendanceReportModel
                              .data![i].attandance![j].empId!.phoneNumber ==
                          null
                      ? ""
                      : attendanceReportModel
                          .data![i].attandance![j].empId!.phoneNumber;
          final role = attendanceReportModel.data![i].attandance![j].empId ==
                  null
              ? ""
              : attendanceReportModel.data![i].attandance![j].empId!.role ==
                      null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].empId!.role;
          final userName =
              attendanceReportModel.data![i].attandance![j].empId == null
                  ? ""
                  : attendanceReportModel
                              .data![i].attandance![j].empId!.userName ==
                          null
                      ? ""
                      : attendanceReportModel
                          .data![i].attandance![j].empId!.userName;
          final dob = attendanceReportModel.data![i].attandance![j].empId ==
                  null
              ? ""
              : attendanceReportModel.data![i].attandance![j].empId!.dob == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].empId!.dob;
          final gender = attendanceReportModel.data![i].attandance![j].empId ==
                  null
              ? ""
              : attendanceReportModel.data![i].attandance![j].empId!.gender ==
                      null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].empId!.gender;
          final assignedUnitId =
              attendanceReportModel.data![i].attandance![j].empId == null
                  ? ""
                  : attendanceReportModel
                              .data![i].attandance![j].empId!.assiginedUnitId ==
                          null
                      ? ""
                      : attendanceReportModel
                          .data![i].attandance![j].empId!.assiginedUnitId;
          final assignedTo =
              attendanceReportModel.data![i].attandance![j].empId == null
                  ? ""
                  : attendanceReportModel
                              .data![i].attandance![j].empId!.assignedTo ==
                          null
                      ? ""
                      : attendanceReportModel
                          .data![i].attandance![j].empId!.assignedTo;
          final attendnaceDate = attendanceReportModel
                      .data![i].attandance![j].attandanceDate ==
                  null
              ? ""
              : attendanceReportModel.data![i].attandance![j].attandanceDate;
          final description =
              attendanceReportModel.data![i].attandance![j].description == null
                  ? ""
                  : attendanceReportModel.data![i].attandance![j].description;

          if (attendanceid!.isEmpty) {
            return null;
          } else {
            Map data = {
              'dateid': dateid,
              'attendanceid': attendanceid,
              'isPresent': isPresent,
              'leaveType': leaveType,
              'isSpecialDay': isSpecialDay,
              'empId': empId,
              'phoneNumber': phoneNumber,
              'role': role,
              'userName': userName,
              'dob': dob,
              'gender': gender,
              'assignedUnitId': assignedUnitId,
              'assignedTo': assignedTo,
              'attendnaceDate': attendnaceDate,
              "description": description
            };
            print(data);

            ///
            attendanceDetails(data);
          }
        }
      }
      emit(AttendanceReportsuccess(
          attendanceReportModel: attendanceReportModel));
    } else if (attendanceReportModel.status == false) {
      emit(AttendanceReportError(error: attendanceReportModel.msg.toString()));
    }
  }
}
