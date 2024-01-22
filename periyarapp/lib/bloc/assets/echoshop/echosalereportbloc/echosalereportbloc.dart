import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echosalereportbloc/echosalereportevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/echosalereportbloc/echosalereportstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echosalesreportmodel.dart';

class GetEchoSaleReportBloc
    extends Bloc<EchoSaleReportEvent, EchoSaleReportState> {
  GetEchoSaleReportBloc() : super(EchoSaleReportState()) {
    on<GetEchoSaleReportEvent>(_getEchoSaleReportEvent);
  }

  Future<FutureOr<void>> _getEchoSaleReportEvent(
      GetEchoSaleReportEvent event, Emitter<EchoSaleReportState> emit) async {
    emit(ReportGenerating());
    EchoSalesReportModel echoSalesReportModel;

    Map map = {
      "date": event.date,
    };

    echoSalesReportModel = await AuthRepository()
        .echosalereport(url: '/sales/report/ecoshop', data: map);
    if (echoSalesReportModel.status == true) {
      emit(EchoSaleReportSuccess(echoSalesReportModel: echoSalesReportModel));
    } else {
      emit(EchoSaleReportError());
    }
  }
}
