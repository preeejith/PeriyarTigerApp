import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/bloc/vehicle/eventvehicle.dart';
import 'package:parambikulam/bloc/vehicle/statevehicle.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/models/vehicleadded.dart';
import 'package:parambikulam/data/models/vehiclemodifieddata.dart';

class BlocVehicle extends Bloc<EventVehicle, StateVehicle> {
  BlocVehicle() : super(StateVehicle()) {
    on<AddVehicle>(_addVehicle);
    on<UpdateVehicle>(_updateVehicle);
    on<RemoveVehicle>(_removeVehicle);
    on<RefreshEvent>(_refreshEvent);
  }

  Future<FutureOr<void>> _addVehicle(
      AddVehicle event, Emitter<StateVehicle> emit) async {
    Map map = {
      "vehicle": [
        {
          "vehicle": event.vehicleName,
          "bookingDate": event.bookingDate,
        }
      ],
      "cart": event.cartId,
    };

    if (event.isOffline == false) {
      BookingSummaryAll bookingSummaryAll;
      var url =
          '/entrypointcart/get?id=' + event.cartId.toString() + "&type=Counter";
      VehicleAdded vehicleAdded;

      vehicleAdded = await AuthRepository()
          .addVehicleData(url: '/vehicle/checkpoint/add', data: map);

      if (vehicleAdded.status == true) {
        bookingSummaryAll =
            await AuthRepository().getPartialBookingDataTwo(url: url);

        emit(VehicleAddedSuccess(
          vehicleAdded: vehicleAdded,
          index: event.index,
          bookingSummaryAll: bookingSummaryAll,
        ));
      }
    } else {
      event.vehicleDetailsList!.add({
        "vehicleName": event.vehicleName,
        "bookingDate": event.date,
        "charge": event.vehicleAmount,
      });
      event.offlineBooking!.vehicleList = event.vehicleDetailsList!;
      event.offlineBooking!.totalAmount =
          event.offlineBooking!.totalAmount! + event.vehicleAmount!;
      emit(VehicleAddedSuccess(
        index: event.index,
      ));
    }
  }

  Future<FutureOr<void>> _updateVehicle(
      UpdateVehicle event, Emitter<StateVehicle> emit) async {
    print("Inside Update V. Bloc");
    if (event.isOffline == false) {
      BookingSummaryAll bookingSummaryAll;
      var url = '/cart/get?id=' + event.cartId.toString() + "&type=Counter";
      VehicleModified vehicleModified;
      Map map = {
        "id": event.id,
        "vehicle": event.vehicleName,
      };

      vehicleModified = await AuthRepository()
          .vehicleModified(url: '/vehicle/checkpoint/edit', data: map);
      if (vehicleModified.status == true) {
        print("Update V. Success");
        bookingSummaryAll =
            await AuthRepository().getPartialBookingDataTwo(url: url);

        emit(VehicleUpdatedSuccess(
          isOffline: event.isOffline,
          vehicleModified: vehicleModified,
          index: event.index,
          bookingSummaryAll: bookingSummaryAll,
        ));
        print("Update V. VehicleUpdatedSuccess Yielded");
      }
    } else {
      print("------------------------");
      print(event.vehicleDetailsList);
      print("------------------------");
      int oldAmount = int.parse(event
          .vehicleDetailsList![int.parse(event.index.toString())]['charge']
          .toString());
      print("oldAmount $oldAmount");
      event.vehicleDetailsList![int.parse(event.index.toString())] = {
        "vehicleName": event.vehicleName,
        "bookingDate": event.bookingDate,
        "charge": event.vehicleAmount,
      };
      event.offlineBooking!.totalAmount =
          (event.offlineBooking!.totalAmount! - oldAmount) +
              event.vehicleAmount!;
      event.offlineBooking!.vehicleList = event.vehicleDetailsList!;
      print(event.offlineBooking!.vehicleList);
      emit(VehicleUpdatedSuccess(
        index: event.index,
        isOffline: event.isOffline,
      ));
    }
  }

  Future<FutureOr<void>> _removeVehicle(
      RemoveVehicle event, Emitter<StateVehicle> emit) async {
    if (event.isOffline == false) {
      BookingSummaryAll bookingSummaryAll;
      var url = '/cart/get?id=' + event.cartId.toString() + "&type=Counter";
      VehicleModified vehicleModified;
      Map map = {
        "id": event.id,
      };
      print("Vehicle Remove Data - " + map.toString());
      vehicleModified = await AuthRepository()
          .vehicleModified(url: '/vehicle/checkpoint/remove', data: map);
      // print(
      //     vehicleAdded.status.toString() + " - " + vehicleAdded.msg.toString());
      if (vehicleModified.status == true) {
        bookingSummaryAll =
            await AuthRepository().getPartialBookingDataTwo(url: url);

        emit(VehicleRemovededSuccess(
          isOffline: event.isOffline,
          vehicleModified: vehicleModified,
          index: event.index,
          bookingSummaryAll: bookingSummaryAll,
        ));
      }
    } else {
      int oldAmount = int.parse(event.vehicleAmount.toString());
      event.vehicleDetailsList!.removeAt(int.parse(event.index.toString()));
      event.offlineBooking!.vehicleList = event.vehicleDetailsList!;
      event.offlineBooking!.totalAmount =
          (event.offlineBooking!.totalAmount! - oldAmount);
      print(event.offlineBooking!.vehicleList);
      emit(VehicleRemovededSuccess(
        isOffline: event.isOffline,
        index: event.index,
      ));
    }
  }

  Future<FutureOr<void>> _refreshEvent(
      RefreshEvent event, Emitter<StateVehicle> emit) async {
    emit(RefreshState());
  }

//   @override
//   Stream<StateVehicle> mapEventToState(EventVehicle event) async* {
//     if (event is AddVehicle) {
//       Map map = {
//         "vehicle": [
//           {
//             "vehicle": event.vehicleName,
//             "bookingDate": event.bookingDate,
//           }
//         ],
//         "cart": event.cartId,
//       };

//       if (event.isOffline == false) {
//         BookingSummaryAll bookingSummaryAll;
//         var url = '/cart/get?id=' + event.cartId.toString() + "&type=Counter";
//         VehicleAdded vehicleAdded;

//         print("Vehicle Map Data - " + map.toString());
//         vehicleAdded = await AuthRepository()
//             .addVehicleData(url: '/vehicle/add', data: map);
//         // print(
//         //     vehicleAdded.status.toString() + " - " + vehicleAdded.msg.toString());
//         if (vehicleAdded.status == true) {
//           bookingSummaryAll =
//               await AuthRepository().getPartialBookingDataTwo(url: url);

//           yield VehicleAddedSuccess(
//             vehicleAdded: vehicleAdded,
//             index: event.index,
//             bookingSummaryAll: bookingSummaryAll,
//           );
//         }
//       } else {
//         // try {

//         // } catch (e) {
//         //   print(e);
//         // }
//         event.vehicleDetailsList!.add({
//           "vehicleName": event.vehicleName,
//           "bookingDate": event.date,
//           "charge": event.vehicleAmount,
//         });
//         event.offlineBooking!.vehicleList = event.vehicleDetailsList!;
//         event.offlineBooking!.totalAmount =
//             event.offlineBooking!.totalAmount! + event.vehicleAmount!;
//         yield VehicleAddedSuccess(
//           index: event.index,
//         );
//         print(event.offlineBooking!.vehicleList);
//         // yield VehicleAddedSuccess(
//         //   index: event.index,
//         // );
//       }
//     }
//     if (event is UpdateVehicle) {
//       print("Inside Update V. Bloc");
//       if (event.isOffline == false) {
//         BookingSummaryAll bookingSummaryAll;
//         var url = '/cart/get?id=' + event.cartId.toString() + "&type=Counter";
//         VehicleModified vehicleModified;
//         Map map = {
//           "id": event.id,
//           "vehicle": event.vehicleName,
//         };
//         print("Vehicle Edit Data - " + map.toString());
//         vehicleModified = await AuthRepository()
//             .vehicleModified(url: '/vehicle/edit', data: map);
//         // print(
//         //     vehicleAdded.status.toString() + " - " + vehicleAdded.msg.toString());
//         if (vehicleModified.status == true) {
//           print("Update V. Success");
//           bookingSummaryAll =
//               await AuthRepository().getPartialBookingDataTwo(url: url);

//           yield VehicleUpdatedSuccess(
//             isOffline: event.isOffline,
//             vehicleModified: vehicleModified,
//             index: event.index,
//             bookingSummaryAll: bookingSummaryAll,
//           );
//           print("Update V. VehicleUpdatedSuccess Yielded");
//         }
//       } else {
//         print("------------------------");
//         print(event.vehicleDetailsList);
//         print("------------------------");
//         int oldAmount = int.parse(event
//             .vehicleDetailsList![int.parse(event.index.toString())]['charge']
//             .toString());
//         print("oldAmount $oldAmount");
//         event.vehicleDetailsList![int.parse(event.index.toString())] = {
//           "vehicleName": event.vehicleName,
//           "bookingDate": event.bookingDate,
//           "charge": event.vehicleAmount,
//         };
//         event.offlineBooking!.totalAmount =
//             (event.offlineBooking!.totalAmount! - oldAmount) +
//                 event.vehicleAmount!;
//         event.offlineBooking!.vehicleList = event.vehicleDetailsList!;
//         print(event.offlineBooking!.vehicleList);
//         yield VehicleUpdatedSuccess(
//           index: event.index,
//           isOffline: event.isOffline,
//         );
//       }
//     }
//     if (event is RemoveVehicle) {
//       if (event.isOffline == false) {
//         BookingSummaryAll bookingSummaryAll;
//         var url = '/cart/get?id=' + event.cartId.toString() + "&type=Counter";
//         VehicleModified vehicleModified;
//         Map map = {
//           "id": event.id,
//         };
//         print("Vehicle Remove Data - " + map.toString());
//         vehicleModified = await AuthRepository()
//             .vehicleModified(url: '/vehicle/remove', data: map);
//         // print(
//         //     vehicleAdded.status.toString() + " - " + vehicleAdded.msg.toString());
//         if (vehicleModified.status == true) {
//           bookingSummaryAll =
//               await AuthRepository().getPartialBookingDataTwo(url: url);

//           yield VehicleRemovededSuccess(
//             isOffline: event.isOffline,
//             vehicleModified: vehicleModified,
//             index: event.index,
//             bookingSummaryAll: bookingSummaryAll,
//           );
//         }
//       } else {
//         int oldAmount = int.parse(event.vehicleAmount.toString());
//         event.vehicleDetailsList!.removeAt(int.parse(event.index.toString()));
//         event.offlineBooking!.vehicleList = event.vehicleDetailsList!;
//         event.offlineBooking!.totalAmount =
//             (event.offlineBooking!.totalAmount! - oldAmount);
//         print(event.offlineBooking!.vehicleList);
//         yield VehicleRemovededSuccess(
//           isOffline: event.isOffline,
//           index: event.index,
//         );
//       }
//     }

//     if (event is RefreshEvent) {
//       yield RefreshState();
//     }
//   }
}
