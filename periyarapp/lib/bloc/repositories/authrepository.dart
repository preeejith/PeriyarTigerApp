import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/data/models/addperson.dart';
import 'package:parambikulam/data/models/addroom.dart';
import 'package:parambikulam/data/models/assetsmodel/addassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/assetsdetailedview.dart';
import 'package:parambikulam/data/models/assetsmodel/assetseditmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/assetswithout_requestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echosalesdetailedmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echosalesreportmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/echoshopsalesmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestdetailedmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestviewmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/newrequestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/getibholidaysmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibgetreservationdatamodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibprogramsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/ibreservationmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/reservationeditmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ib/reservationremovemodel.dart';

import 'package:parambikulam/data/models/assetsmodel/login_employeemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/loginsucessemployee_model.dart';
import 'package:parambikulam/data/models/assetsmodel/new/addassetfornostockmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/addassetsmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/assetstransfermainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/damagerequestacceptmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/employeeassignmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/employeeassignunitmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/iclogmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/ictoicrequestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/icunitassetsviewmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/removeemployeemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/repairrequestacceptmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestmaindetailedmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestviewmainmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/search_assetsidmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferstockupdationmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithoutrequestmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/transferwithrequestmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/viewallemployeemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/addproductimagemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/addproductmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/productdeletemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/producteditmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmaindetailedmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/profileupdatemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchasedetailed.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchaseordermodel.dart';

import 'package:parambikulam/data/models/assetsmodel/requestrejectmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/requesttransfermodel.dart';

import 'package:parambikulam/data/models/assetsmodel/unitsdetailedviewmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/viewrequestdetailedmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewrequestunitmodel.dart';
import 'package:parambikulam/data/models/attendance/attendancereportmodel.dart';
import 'package:parambikulam/data/models/attendance/halt/haltreportmodel.dart';
import 'package:parambikulam/data/models/attendance/halt/haltuploadmodel.dart';
import 'package:parambikulam/data/models/attendance/uploadattentancemodel.dart';

import 'package:parambikulam/data/models/bookingdetails.dart';
import 'package:parambikulam/data/models/bookingpartial.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/data/models/bookingsummaryall.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/data/models/commonmodel.dart';
import 'package:parambikulam/data/models/echoshopdownloadmodel.dart';
import 'package:parambikulam/data/models/entrymodel/commonentryModel.dart';
import 'package:parambikulam/data/models/finalsubmission.dart';
import 'package:parambikulam/data/models/offlineticket.dart';
import 'package:parambikulam/data/models/packagerate.dart';
import 'package:parambikulam/data/models/previousbooking2.dart';
import 'package:parambikulam/data/models/printticket.dart';
import 'package:parambikulam/data/models/product/productlistmodel.dart';
import 'package:parambikulam/data/models/programmz.dart';
import 'package:parambikulam/data/models/removeperson.dart';
import 'package:parambikulam/data/models/server_response_model.dart';
import 'package:parambikulam/data/models/test.dart';
import 'package:parambikulam/data/models/userprofile.dart';
import 'package:parambikulam/data/models/vehicleadded.dart';
import 'package:parambikulam/data/models/vehiclemodel.dart';
import 'package:parambikulam/data/models/vehiclemodifieddata.dart';
import 'package:parambikulam/data/web_client.dart';
import 'package:parambikulam/ui/assets/local/model/echoshopsalesrpeortmodel.dart';

class AuthRepository {
  // getTermsAndConditions
  bool? internetStatus = false;

  Future<OfflineLineTicket> getAllTickets(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final OfflineLineTicket userModel = OfflineLineTicket.fromJson(response);
    return userModel;
  }

  Future<CommonModel> sendBookedData(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final CommonModel userModel = CommonModel.fromJson(response);
    return userModel;
  }

  Future<TermsAndPolicy> getTermsAndConditions({required String url}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final TermsAndPolicy userModel = TermsAndPolicy.fromJson(response);
    return userModel;
  }

  Future<ServerResponseModel> login({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ServerResponseModel userModel =
        ServerResponseModel.fromJson(response);
    return userModel;
  }

  Future<Programmz> getProgramms({required String url, dynamic data}) async {
    print(url);
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final Programmz programmz = Programmz.fromJson(response);
    return programmz;
  }

  Future<BookingSummary> getBookingSummary(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final BookingSummary bookingSummary = BookingSummary.fromJson(response);
    return bookingSummary;
  }

  Future<PreviousBooking2> getPreviousBookings(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final PreviousBooking2 programmz = PreviousBooking2.fromJson(response);
    return programmz;
  }

  Future<BookingDetails> getBookingDetails({required String url}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final BookingDetails bookingDetails = BookingDetails.fromJson(response);
    return bookingDetails;
  }

  Future<PackageRate> getProgramIndividualDetails({required String url}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final PackageRate bookingDetails = PackageRate.fromJson(response);
    return bookingDetails;
  }

  Future<PartialBooking> getPartialBookingData(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final PartialBooking bookingDetails = PartialBooking.fromJson(response);
    return bookingDetails;
  }

  Future<BookingSummaryAll> getPartialBookingDataTwo(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final BookingSummaryAll bookingDetails =
        BookingSummaryAll.fromJson(response);
    return bookingDetails;
  }

  Future<VehicleModel> getVehicleInformations(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final VehicleModel bookingDetails = VehicleModel.fromJson(response);
    return bookingDetails;
  }

  Future<AddPerson> savePersonInformation(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddPerson bookingDetails = AddPerson.fromJson(response);
    return bookingDetails;
  }

  Future<VehicleAdded> addVehicleData(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final VehicleAdded bookingDetails = VehicleAdded.fromJson(response);
    return bookingDetails;
  }

  Future<VehicleModified> vehicleModified(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final VehicleModified bookingDetails = VehicleModified.fromJson(response);
    return bookingDetails;
  }

  Future<FinalSubmissionModel> finalSubmission(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final FinalSubmissionModel finalSubmissionModel =
        FinalSubmissionModel.fromJson(response);
    return finalSubmissionModel;
  }

  Future<AddPerson> uploadProof({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final AddPerson finalSubmissionModel = AddPerson.fromJson(response);
    return finalSubmissionModel;
  }

  Future<RemovePersonModel> removePerson(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final RemovePersonModel removePersonModel =
        RemovePersonModel.fromJson(response);
    return removePersonModel;
  }

  Future<AddRoom> addRoom({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddRoom addRoom = AddRoom.fromJson(response);
    return addRoom;
  }

  Future<UserProfileModel> getUserData(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final UserProfileModel userProfileModel =
        UserProfileModel.fromJson(response);
    return userProfileModel;
  }

  Future<TicketPDF> printPdf({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final TicketPDF addRoom = TicketPDF.fromJson(response);
    return addRoom;
  }

  /////////new repository
  Future<EmployeeloginModel> employeelogin(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EmployeeloginModel employeeloginModel =
        EmployeeloginModel.fromJson(response);
    return employeeloginModel;
  }

/////route changed
  Future<AddAssetsModel> addassets({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddAssetsModel addAssetsModel = AddAssetsModel.fromJson(response);
    return addAssetsModel;
  }

////uploadattendance
  ///
  ///
  ///
  Future<UploadAttendanceModel> uploadattendance(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final UploadAttendanceModel uploadattendancemodel =
        UploadAttendanceModel.fromJson(response);
    return uploadattendancemodel;
  }

  //////attendance
  ///
  ///report attendance
  ///
  ///
  Future<AttendanceReportModel> attendancereport(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AttendanceReportModel attendancereportmodel =
        AttendanceReportModel.fromJson(response);
    return attendancereportmodel;
  }

  ///halt add
  Future<HaltUploadModel> haltupload(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final HaltUploadModel haltuploadmodel = HaltUploadModel.fromJson(response);
    return haltuploadmodel;
  }

  ////halt report
  ///
  Future<HaltReportModel> haltreport(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final HaltReportModel haltreportmodel = HaltReportModel.fromJson(response);
    return haltreportmodel;
  }

  ///searchassetid
  Future<AssetsIdSearchModel> searchassetid(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AssetsIdSearchModel assetidsearch =
        AssetsIdSearchModel.fromJson(response);
    return assetidsearch;
  }

//ictoicrequest

  Future<IcToIcRequestModel> ictoicrequest(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final IcToIcRequestModel ictoicrequestmodel =
        IcToIcRequestModel.fromJson(response);
    return ictoicrequestmodel;
  }

  ///view all assetsmain
  ///chnaged
  Future<ViewAllAssetsModel> viewallassets(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final ViewAllAssetsModel viewallassets =
        ViewAllAssetsModel.fromJson(response);
    return viewallassets;
  }

  Future<IbGetReservationDataModel> getreservationdata(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final IbGetReservationDataModel getreservationdatamodel =
        IbGetReservationDataModel.fromJson(response);
    return getreservationdatamodel;
  }

  ///
  ///
  /////view view request
  // Future<ViewRequestMainModel> viewrequestmain(
  //     {required String url, dynamic data}) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     // print("Not connected to internet");
  //     Fluttertoast.showToast(
  //       msg: "No internet connection",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   }

  //   final dynamic response = await WebClient.get(url);

  //   final ViewRequestMainModel userModel =
  //       ViewRequestMainModel.fromJson(response);

  //   return userModel;
  // }

//new

  Future<dynamic> viewrequestmain({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    // final ViewRequestMainModel assetidsearch =
    //     ViewRequestMainModel.fromJson(response);
    return response;
  }

  ///offline
  ///
  Future<ViewRequestMainModel> viewrequestmain2(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ViewRequestMainModel assetidsearch =
        ViewRequestMainModel.fromJson(response);
    return assetidsearch;
  }

  ////product Edit
  ///
  ///
  ///
  Future<ProductEditModeldart> productedit(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ProductEditModeldart producteditmodel =
        ProductEditModeldart.fromJson(response);
    return producteditmodel;
  }

//productdelete
  Future<Productdeletemodel> productdelete(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final Productdeletemodel productdeletemodel =
        Productdeletemodel.fromJson(response);
    return productdeletemodel;
  }

  Future<SalesdetailedModel> salesdetailed(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final SalesdetailedModel productdeletemodel =
        SalesdetailedModel.fromJson(response);
    return productdeletemodel;
  }

//download echoshop
  ///
  Future<dynamic> viewprofile({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    // final ViewProfileModel viewprofilemodel =
    //     ViewProfileModel.fromJson(response);
    return response;
  }

////IB
  ///
  ///////////
  Future<IbProgramsModel> ibprogram({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final IbProgramsModel ibprogrammodel = IbProgramsModel.fromJson(response);
    return ibprogrammodel;
  }
//view product main

  Future<ViewProductMainModel> viewproductmain(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final ViewProductMainModel viewproductmainmodel =
        ViewProductMainModel.fromJson(response);
    return viewproductmainmodel;
  }

  //download echoshop
  Future<dynamic> downloadeEchoProducts(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    // final EchoShopProductDownloadModel viewproductmainmodel =
    //     EchoShopProductDownloadModel.fromJson(response);
    return response;
  }

  Future<SalesReport> downloadsalesreport(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final SalesReport salesReport = SalesReport.fromJson(response);
    return salesReport;
  }

  ////download product
  ///
  Future<EchoShopProductDownloadModel> downloadeOnlineProducts(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final EchoShopProductDownloadModel echoShopProductDownloadModel =
        EchoShopProductDownloadModel.fromJson(response);
    return echoShopProductDownloadModel;
  }

/////view productmain detailed
  Future<ViewProductMainDetailedModel> viewproductmaindetailed(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ViewProductMainDetailedModel viewproductmaindetailedmodel =
        ViewProductMainDetailedModel.fromJson(response);
    return viewproductmaindetailedmodel;
  }

  Future<ViewAllEmployeeModel> viewallemployee2(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ViewAllEmployeeModel viewallemployee2model =
        ViewAllEmployeeModel.fromJson(response);
    return viewallemployee2model;
  }

  ///view all employees
  Future<dynamic> viewallemployee({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    // final ViewAllEmployeeModel viewallemployeemodel =
    //     ViewAllEmployeeModel.fromJson(response);
    return response;
  }

////addproductmainrepo
  Future<AddProductMainModel> addproductmain(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddProductMainModel viewallemployeemodel =
        AddProductMainModel.fromJson(response);
    return viewallemployeemodel;
  }

  ///add productimage
  ///
  ///
  Future<AddProductImageModel> addproductimage(
      {required String url,
      required String id,
      required String image,
      required String coverimage}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.files(url, image, coverimage, id);
    final AddProductImageModel addproductimagemodel =
        AddProductImageModel.fromJson(response);
    return addproductimagemodel;
  }

////new image

  Future<AddProductImageModel> addproductimage2(
      {required String url, required String id, required String image}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.files3(url, image, id);
    final AddProductImageModel addproductimagemodel =
        AddProductImageModel.fromJson(response);
    return addproductimagemodel;
  }

////newpurchasedrop
  Future<dynamic> newpurchasedrop({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    // final NewPurchaseDropModel viewprofilemodel =
    //     NewPurchaseDropModel.fromJson(response);
    return response;
  }

  ////PURCHASEorderview
  ///
  ///
  Future<ViewPurchaseListModel> viewpurchaseorder(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final ViewPurchaseListModel viewprofilemodel =
        ViewPurchaseListModel.fromJson(response);
    return viewprofilemodel;
  }

////getibholidays

  Future<GetIbHolidaysModel> getibholidays(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final GetIbHolidaysModel getibholidaysmodel =
        GetIbHolidaysModel.fromJson(response);
    return getibholidaysmodel;
  }

  ///viewunits
  Future<dynamic> viewunits({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    // final IcViewUnitsModel viewunitsmodel = IcViewUnitsModel.fromJson(response);
    return response;
  }
//viewmyrequest

  Future<dynamic> viewmyrequest({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    // final MyRequestViewModel viewunitsmodel =
    //     MyRequestViewModel.fromJson(response);
    return response;
  }

  Future<MyRequestViewModel> viewmyrequest2(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final MyRequestViewModel viewunitsmodel =
        MyRequestViewModel.fromJson(response);
    return viewunitsmodel;
  }

  ///assetsdetailed
  Future<AssetsDetailedViewModel> assetsdetailedview(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AssetsDetailedViewModel assetsDetailedView =
        AssetsDetailedViewModel.fromJson(response);
    return assetsDetailedView;
  }

  ///assignemployee
  ///
  Future<EmployeeassignModel> employeeassign(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EmployeeassignModel assetsDetailedView =
        EmployeeassignModel.fromJson(response);
    return assetsDetailedView;
  }

//iclogmain
  Future<IcLogModel> iclogmain({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final IcLogModel iclogmain = IcLogModel.fromJson(response);
    return iclogmain;
  }

//////icunitsassetsview
  Future<IcUnitAssetsViewModel> icunitsassetsview(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final IcUnitAssetsViewModel icunitsassetsviewmodel =
        IcUnitAssetsViewModel.fromJson(response);
    return icunitsassetsviewmodel;
  }

  ////myrequestdetailedmodeltranse
  ///
  ///
  Future<MyrequestDetailedModel> myrequestdetailed(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final MyrequestDetailedModel assetsDetailedView =
        MyrequestDetailedModel.fromJson(response);
    return assetsDetailedView;
  }

  ///removeemployee
  ///
  Future<RemoveEmployeeModel> removeemployee(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final RemoveEmployeeModel removeemployeemodel =
        RemoveEmployeeModel.fromJson(response);
    return removeemployeemodel;
  }

////view purchaseorderdetailed
  ///
  ///
  ///
  ///
  ///
  ///transferwithrequest
  Future<TransferWithRequestMainModel> transferwithrequest(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final TransferWithRequestMainModel assetsDetailedView =
        TransferWithRequestMainModel.fromJson(response);
    return assetsDetailedView;
  }

  ///emplloyeeasignunit
  Future<EmployeeAssignUnitModel> employeeassignunit(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EmployeeAssignUnitModel assetsDetailedView =
        EmployeeAssignUnitModel.fromJson(response);
    return assetsDetailedView;
  }

  Future<ViewPurchaseDetailedModel> viewpurchasedeatailed(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ViewPurchaseDetailedModel assetsDetailedView =
        ViewPurchaseDetailedModel.fromJson(response);
    return assetsDetailedView;
  }
  /////requestmaindetailed
  /////aju
  // Future<dynamic> requestmaindetailed(
  //     {required String url, dynamic data}) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     Fluttertoast.showToast(
  //       msg: "No internet connection",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   }
  //   final dynamic response = await WebClient.post(url, data);
  //   // final RequestMainDetailedModel requestdetailed =
  //   //     RequestMainDetailedModel.fromJson(response);
  //   return response;
  // }

  Future<RequestMainDetailedModel> requestmaindetailed(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final RequestMainDetailedModel assetsDetailedView =
        RequestMainDetailedModel.fromJson(response);
    return assetsDetailedView;
  }

////Damage request Accept
  Future<DamageRequestAcceptModel> damagerequestaccept(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final DamageRequestAcceptModel assetsDetailedView =
        DamageRequestAcceptModel.fromJson(response);
    return assetsDetailedView;
  }

////repairrequestaccept
  ///
  ///
  Future<RepairRequestAcceptModel> repairrequestaccept(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final RepairRequestAcceptModel assetsDetailedView =
        RepairRequestAcceptModel.fromJson(response);
    return assetsDetailedView;
  }
  //   Future<dynamic> requestmaindetailed(
  //     {required String url, dynamic data}) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     Fluttertoast.showToast(
  //       msg: "No internet connection",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   }
  //   final dynamic response = await WebClient.post(url, data);
  //   final a requestdetailed =
  //       RequestMainDetailedModel.fromJson(response);
  //   // return response;
  // }
  ////send Request
  ///
  ///
  //  Future<SendRequestModel> sendrequest(
  //     {required String url, dynamic data}) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     Fluttertoast.showToast(
  //       msg: "No internet connection",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //     );
  //   }
  //   final dynamic response = await WebClient.post(url, data);
  //   final SendRequestModel assetsDetailedView =
  //       SendRequestModel.fromJson(response);
  //   return assetsDetailedView;
  // }

  /////newrequestsend
  ///
  ///
  Future<NewRequestModel> sendnewrequest(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final NewRequestModel assetsDetailedView =
        NewRequestModel.fromJson(response);
    return assetsDetailedView;
  }

////profileedit
  Future<ViewProfileUpdateModel> profileedit(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ViewProfileUpdateModel assetsDetailedView =
        ViewProfileUpdateModel.fromJson(response);
    return assetsDetailedView;
  }

/////Addassetsmain
  Future<AddAssetMainModel> addassetsmain(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddAssetMainModel assetsDetailedView =
        AddAssetMainModel.fromJson(response);
    return assetsDetailedView;
  }

  Future<AddAssetNoStockModel> addassetsnostock(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddAssetNoStockModel addAssetNoStockModel =
        AddAssetNoStockModel.fromJson(response);
    return addAssetNoStockModel;
  }

  ///transfer stockupdation
  Future<TransgferStockUpdationModel> transferstockupdation(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final TransgferStockUpdationModel transferstockupdationmodel =
        TransgferStockUpdationModel.fromJson(response);
    return transferstockupdationmodel;
  }

  Future<AddAssetMainModel> addproduct(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AddAssetMainModel assetsDetailedView =
        AddAssetMainModel.fromJson(response);
    return assetsDetailedView;
  }

  /////echoshopreport
  ///
  Future<EchoSalesReportModel> echosalereport(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EchoSalesReportModel echosalereport =
        EchoSalesReportModel.fromJson(response);
    return echosalereport;
  }

////assetstransfermain
  Future<AssetsTrasnferMainModel> assetstransfermain(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AssetsTrasnferMainModel echosalereport =
        AssetsTrasnferMainModel.fromJson(response);
    return echosalereport;
  }

  ///units detaied view

  Future<UnitsDetailedViewModel> unitsdetailedview(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final UnitsDetailedViewModel unitsDetailedView =
        UnitsDetailedViewModel.fromJson(response);
    return unitsDetailedView;
  }

  ///assetswithout any request to the units
  Future<AssetsWithOutRequestModel> assetswithoutrequest(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AssetsWithOutRequestModel unitsDetailedView =
        AssetsWithOutRequestModel.fromJson(response);
    return unitsDetailedView;
  }

  ///for ib reservation
  Future<IbReservationModel> ibreservation(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final IbReservationModel ibreservationmodel =
        IbReservationModel.fromJson(response);
    return ibreservationmodel;
  }

  Future<ReservationEditModel> ibreservationedit(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ReservationEditModel ibreservationeditmodel =
        ReservationEditModel.fromJson(response);
    return ibreservationeditmodel;
  }

  ///remove reservation list
  ///
  Future<ReservationRemovelModel> ibreservationremove(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ReservationRemovelModel ibreservationremovemodel =
        ReservationRemovelModel.fromJson(response);
    return ibreservationremovemodel;
  }

/////requestview form the Ic
  ///
  Future<ViewUnitsRequestModel> viewunitrequest(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final ViewUnitsRequestModel unitsDetailedView =
        ViewUnitsRequestModel.fromJson(response);
    return unitsDetailedView;
  }

/////////////
  ///request transfer
  ///no block added
  Future<RequestTransferModel> requesttransfer(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final RequestTransferModel unitsDetailedView =
        RequestTransferModel.fromJson(response);
    return unitsDetailedView;
  }

  ///
  ///
  ///
  ///assets transfer without request
  Future<TransferwithoutrequestmainModel> transferwithoutrequestmain(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final TransferwithoutrequestmainModel unitsDetailedView =
        TransferwithoutrequestmainModel.fromJson(response);
    return unitsDetailedView;
  }

  ///echoshopsale
/////model want to chnage
  Future<EchoShopSaleModel> echoshopsale(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EchoShopSaleModel unitsDetailedView =
        EchoShopSaleModel.fromJson(response);
    return unitsDetailedView;
  }

//reject request
  Future<RequestRejectModel> rejectrequest(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final RequestRejectModel unitsDetailedView =
        RequestRejectModel.fromJson(response);
    return unitsDetailedView;
  }

////requestdetailed view
//no bloc done her
  Future<UnitRequestDetailedModel> unitrequesteddetailed(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final UnitRequestDetailedModel unitsDetailedView =
        UnitRequestDetailedModel.fromJson(response);
    return unitsDetailedView;
  }

/////assetsedit
  Future<AssetsEditModel> assetsedit(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final AssetsEditModel assetsDetailedView =
        AssetsEditModel.fromJson(response);
    return assetsDetailedView;
  }

  Future<EmployeeLoginSuccessModel> employeeloginsuccess(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final EmployeeLoginSuccessModel employeeloginsuccessModel =
        EmployeeLoginSuccessModel.fromJson(response);
    return employeeloginsuccessModel;
  }

  Future<ProductListModel> viewallproducts(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final ProductListModel productListModel =
        ProductListModel.fromJson(response);
    return productListModel;
  }

  Future<CommonEntryModel> entryUploadData(
      {required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final CommonEntryModel commonModel = CommonEntryModel.fromJson(response);
    return commonModel;
  }

  Future<BusModel> getBusData({required String url}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print("Not connected to internet");
      Fluttertoast.showToast(
        msg: "Not connected to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.get(url);
    final BusModel busModel = BusModel.fromJson(response);
    return busModel;
  }
}

// checkConnection(){
// bool? internetStatus;
//  checkconnectivity() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   connectivityResult == ConnectivityResult.none
//       ? internetStatus = false
//       : internetStatus = true;
// }
// }
//entry upload Data
Future<bool> checkInternetStatus() async {
  bool? internetStatus = false;
  var connectivityResult = await (Connectivity().checkConnectivity());
  connectivityResult == ConnectivityResult.none
      ? internetStatus = false
      : internetStatus = true;
  return internetStatus;
}

//product
