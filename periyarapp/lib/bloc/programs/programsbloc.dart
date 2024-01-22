import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/programs/programsevent.dart';
import 'package:parambikulam/bloc/programs/programsstate.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/data/models/packagerate.dart';

import 'package:parambikulam/data/models/previousbooking2.dart';
import 'package:parambikulam/data/models/programmz.dart';
import 'package:parambikulam/local/db/dbhelper.dart';
import 'package:parambikulam/utils/helper.dart';
import 'package:parambikulam/utils/pref_manager.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  // var ticketNumber = '';
  DatabaseHelper? db = DatabaseHelper.instance;
  ProgramsBloc() : super(ProgramsState()) {
    on<GetBookingData>(_getBookingData);
    on<CheckAndGetTicket>(_checkAndGetTicket);
    on<GetPrograms>(_getPrograms);
    on<InitialGetBookingDataQr>(_initialGetBookingDataQr);
    on<DoLogout>(_doLogout);
    on<GetPreviousBookings>(_getPreviousBookings);
    on<InitialGetBookingData>(_initialGetBookingData);
    on<HomePageDataNotAvailabale>(_homePageDataNotAvailabale);
    on<NoInternet>(_noInternet);
    on<GetProgramDetails>(_getProgramDetails);
    on<InitialGetBookingDataFromBooking>(_getInitialGetBookingDataFromBooking);
  }

  Future<void> _getInitialGetBookingDataFromBooking(
      InitialGetBookingDataFromBooking event,
      Emitter<ProgramsState> emit) async {
    emit(LoadingGetBookingDataToBooking());
    if (event.isOffline == false) {
      BookingDetails bookingDetails;
      var url = '/booking/ticket?id=' + event.qrId.toString();
      bookingDetails = await AuthRepository().getBookingDetails(url: url);
      if (bookingDetails.status == true) {
        emit(LoadedBookingDataToBooking(bookingDetails: bookingDetails));
      } else {
        emit(BookingsDataNotReceived(error: bookingDetails.msg.toString()));
      }
    } else {
      var ticketIdResult = await event.databaseHelper!
          .addTicketId(event.qrId.toString(), event.offlineBooking);
      print(ticketIdResult);

      emit(LoadedBookingDataToBooking());
    }
  }

  Future<void> _getProgramDetails(
      GetProgramDetails event, Emitter<ProgramsState> emit) async {
    emit(GettingProgramDetails());
    log(event.offlineData.toString());
    if (event.isOffline == true) {
      if (event.offlineData!.isNotEmpty) {
        emit(IndividualProgramDetails(
            isOffline: event.isOffline, offlineData: event.offlineData));
      } else {
        emit(IndividualProgramDetailsNotFound());
      }
    } else {
      PackageRate packageRate;
      var url = '/programme/get?id=' + event.id.toString();
      packageRate =
          await AuthRepository().getProgramIndividualDetails(url: url);
      if (packageRate.status == true) {
        emit(IndividualProgramDetails(
            packageRateData: packageRate, isOffline: event.isOffline));
      }
    }
  }

  Future<FutureOr<void>> _getPrograms(
      GetPrograms event, Emitter<ProgramsState> emit) async {
    if (event.isOffline != true) {
      final token = await PrefManager.getToken();
      Programmz programmz;
      // PreviousBooking2 previousBookings;
//periyarchangeheppen
      programmz = await AuthRepository().getProgramms(
          //periyarchangeheppen
          url: '/programme/getlist/appBooking?started=true&date=${event.date}');
      // previousBookings = await AuthRepository().getPreviousBookings(
      //   url: '/booking/entrypointreport',
      // );
      // print(previousBookings.data);

      // if (programmz.status == true && previousBookings.status == true) {
      //   emit(HomePageDataAvailabale(
      //       isOffline: event.isOffline,
      //       token: token,
      //       programmz: programmz,
      //       previoousBookingData: previousBookings.data));
      // }

      if (programmz.status == true) {
        emit(
          HomePageDataAvailabale(
            isOffline: event.isOffline,
            token: token,
            programmz: programmz,
          ),
        );
      }

      // if (programmz.status == true) {
      //   if (programmz.data!.length > 1) {
      //     // print(programmz.data![].coverImage);
      //     yield ProgramDataAvailable(programData: programmz.data);
      //   }
      // }
    } else {
      emit(HomePageDataAvailabale(
        isOffline: event.isOffline,
      ));
    }
  }

  Future<FutureOr<void>> _initialGetBookingDataQr(
      InitialGetBookingDataQr event, Emitter<ProgramsState> emit) async {
    emit(LoadingGetBookingData());

    BookingDetails bookingDetails;
    var url = '/booking/ticket?id=' + event.qrId;
    bookingDetails = await AuthRepository().getBookingDetails(url: url);
    if (bookingDetails.status == true) {
      emit(LoadedBookingData(bookingDetails: bookingDetails));
    } else {
      emit(PreviousBookingsDataNotReceived(
          error: bookingDetails.msg.toString()));
    }
  }

  Future<FutureOr<void>> _doLogout(
      DoLogout event, Emitter<ProgramsState> emit) async {
    var token = await PrefManager.clearToken();
    if (token == null) {
      emit(TokensCleared());
      // Navigator.pushReplacement(
      //   event.context!,
      //   MaterialPageRoute(builder: (context) => NewHome()),
      // );
    }
  }

  Future<FutureOr<void>> _getPreviousBookings(
      GetPreviousBookings event, Emitter<ProgramsState> emit) async {
    PreviousBooking2 previousBookings;
    previousBookings = await AuthRepository().getPreviousBookings(
      url: '/booking/report',
    );

    if (previousBookings.status == true) {
      // print(previousBookings.data.runtimeType);
      emit(PreviousBookingsDataReceived(
          previoousBookingData: previousBookings.data));
    } else {
      // yield PreviousBookingsDataNotReceived()
    }
  }

  Future<FutureOr<void>> _initialGetBookingData(
      InitialGetBookingData event, Emitter<ProgramsState> emit) async {
    emit(LoadingGetBookingData());
    BookingDetails bookingDetails;
    var url = '/booking/ticket?ticketNumber=' + event.bookingId;
    bookingDetails = await AuthRepository().getBookingDetails(url: url);
    // print(bookingDetails.status);
    if (bookingDetails.status == true) {
      emit(LoadedBookingData(bookingDetails: bookingDetails));
    } else {
      emit(PreviousBookingsDataNotReceived(
          error: bookingDetails.msg.toString()));
    }
  }

  Future<FutureOr<void>> _homePageDataNotAvailabale(
      HomePageDataNotAvailabale event, Emitter<ProgramsState> emit) async {
    emit(NotFound());
  }

  Future<FutureOr<void>> _noInternet(
      NoInternet event, Emitter<ProgramsState> emit) async {
    emit(NoInternetStateHome());
  }

  // @override
  // Stream<ProgramsState> mapEventToState(ProgramsEvent event) async* {
  //   if (event is GetPrograms) {
  //     if (event.isOffline != true) {
  //       final token = await PrefManager.getToken();
  //       Programmz programmz;
  //       PreviousBooking2 previousBookings;
  //       // Map map = {"started": "true"};
  //       programmz = await AuthRepository().getProgramms(
  //           url: '/programme/getlist?started=true&date=${event.date}');
  //       previousBookings = await AuthRepository().getPreviousBookings(
  //         url: '/booking/report',
  //       );

  //       // print(previousBookings.data!.upcoming);
  //       if (programmz.status == true && previousBookings.status == true) {
  //         yield HomePageDataAvailabale(
  //             isOffline: event.isOffline,
  //             token: token,
  //             programmz: programmz,
  //             previoousBookingData: previousBookings.data);
  //       }

  //       // if (programmz.status == true) {
  //       //   if (programmz.data!.length > 1) {
  //       //     // print(programmz.data![].coverImage);
  //       //     yield ProgramDataAvailable(programData: programmz.data);
  //       //   }
  //       // }
  //     } else {
  //       yield HomePageDataAvailabale(
  //         isOffline: event.isOffline,
  //       );
  //     }
  //   }
  //   if (event is InitialGetBookingDataQr) {
  //     yield LoadingGetBookingData();
  //     BookingDetails bookingDetails;
  //     var url = '/booking/ticket?id=' + event.qrId;
  //     bookingDetails = await AuthRepository().getBookingDetails(url: url);
  //     // print(bookingDetails.status);
  //     if (bookingDetails.status == true) {
  //       yield LoadedBookingData(bookingDetails: bookingDetails);
  //     } else {
  //       yield PreviousBookingsDataNotReceived(
  //           error: bookingDetails.msg.toString());
  //     }
  //   }
  //   //

  //   if (event is DoLogout) {
  //     var token = await PrefManager.clearToken();
  //     if (token == null) {
  //       yield TokensCleared();
  //       // Navigator.pushReplacement(
  //       //   event.context!,
  //       //   MaterialPageRoute(builder: (context) => NewHome()),
  //       // );
  //     }
  //   }

  //   if (event is GetPreviousBookings) {
  //     PreviousBooking2 previousBookings;
  //     previousBookings = await AuthRepository().getPreviousBookings(
  //       url: '/booking/report',
  //     );

  //     if (previousBookings.status == true) {
  //       // print(previousBookings.data.runtimeType);
  //       yield PreviousBookingsDataReceived(
  //           previoousBookingData: previousBookings.data);
  //     } else {
  //       // yield PreviousBookingsDataNotReceived()
  //     }
  //   }
  //   if (event is InitialGetBookingData) {
  //     yield LoadingGetBookingData();
  //     BookingDetails bookingDetails;
  //     var url = '/booking/ticket?ticketNumber=' + event.bookingId;
  //     bookingDetails = await AuthRepository().getBookingDetails(url: url);
  //     // print(bookingDetails.status);
  //     if (bookingDetails.status == true) {
  //       yield LoadedBookingData(bookingDetails: bookingDetails);
  //     } else {
  //       yield PreviousBookingsDataNotReceived(
  //           error: bookingDetails.msg.toString());
  //     }
  //   }
  //   if (event is GetProgramDetails) {
  //     yield GettingProgramDetails();
  //     if (event.isOffline == true) {
  //       yield IndividualProgramDetails(
  //           isOffline: event.isOffline, offlineData: event.offlineData);
  //     } else {
  //       PackageRate packageRate;
  //       var url = '/programme/get?id=' + event.id.toString();
  //       packageRate =
  //           await AuthRepository().getProgramIndividualDetails(url: url);
  //       if (packageRate.status == true) {
  //         // print(packageRate.package![0].children.toString());
  //         yield IndividualProgramDetails(
  //             packageRateData: packageRate, isOffline: event.isOffline);
  //       }
  //     }
  //   }

  //   if (event is InitialGetBookingDataFromBooking) {
  //     yield LoadingGetBookingDataToBooking();
  //     if (event.isOffline == false) {
  //       BookingDetails bookingDetails;
  //       var url = '/booking/ticket?id=' + event.qrId.toString();
  //       bookingDetails = await AuthRepository().getBookingDetails(url: url);
  //       // print(bookingDetails.status);
  //       if (bookingDetails.status == true) {
  //         yield LoadedBookingDataToBooking(bookingDetails: bookingDetails);
  //       } else {
  //         yield BookingsDataNotReceived(error: bookingDetails.msg.toString());
  //       }
  //     } else {
  //       var ticketIdResult = await event.databaseHelper!
  //           .addTicketId(event.qrId.toString(), event.offlineBooking);
  //       print(ticketIdResult);

  //       yield LoadedBookingDataToBooking();
  //     }
  //   }

  //   if (event is HomePageDataNotAvailabale) {
  //     yield NotFound();
  //   }

  //   if (event is NoInternet) {
  //     yield NoInternetStateHome();
  //   }
  // }

  FutureOr<void> _checkAndGetTicket(
      CheckAndGetTicket event, Emitter<ProgramsState> emit) async {
    List? termsAndConditions = [];
    try {
      termsAndConditions = await db!.getTermsAndConditionsOffline();
    } catch (e) {}

    if (termsAndConditions!.isNotEmpty || termsAndConditions.length != 0) {
      print(termsAndConditions[0]['ticketNumber']);
      if (termsAndConditions[0]['ticketNumber'] == null) {
        emit(TicketNumberNotFound());
      }
    } else {
      emit(TicketNumberNotFound());
    }
  }

  FutureOr<void> _getBookingData(
      GetBookingData event, Emitter<ProgramsState> emit) async {
    List list = await db!.getFinalBookingData();
    if (list.length != 0) {
      emit(TheFinalBookingData(list: list));
    } else {
      if (event.showToast!) {
        Helper.centerToast("No booking's found");
      }
    }
  }
}
