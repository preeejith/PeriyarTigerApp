import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/addperson/blocaddperson.dart';
import 'package:parambikulam/bloc/addroom/blocaddroom.dart';
import 'package:parambikulam/bloc/addroomperson/blocaddroomperson.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetholidaysbloc/ibgetholidaysbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibgetreservationbloc/ibgetreservationbloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibprogrambloc/ibprogrambloc.dart';
import 'package:parambikulam/bloc/assets/Ibmain/ibreservationbloc/ibreservationbloc.dart';
import 'package:parambikulam/bloc/assets/addassetsbloc/addassetsbloc.dart';
import 'package:parambikulam/bloc/assets/assetsdetailedblo/assetsdetailedbloc.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditbloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/attendancereportbloc/attendancereportbloc.dart';
import 'package:parambikulam/bloc/assets/attendancebloc/uploadattendancebloc/uploadattendancebloc.dart';
import 'package:parambikulam/bloc/assets/authbloc/employeelogin_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/downloadechoproducts.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoShopCartManagementbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echosalereportbloc/echosalereportbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoshopsalebloc/echoshopsalebloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/placeorderbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestdetailedbloc/viewmyrequest_blocdetailed.dart';
import 'package:parambikulam/bloc/assets/haltbloc/haltreportbloc/haltreportbloc.dart';
import 'package:parambikulam/bloc/assets/haltbloc/uploadhaltbloc/uploadhaltbloc.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/damagerequest_blocaccept/damagerequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignbloc/employeeassignbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeassignunitbloc/employeeassign_blocunit.dart';
import 'package:parambikulam/bloc/assets/icbloc/employeeoffline/viewemployeelistbloc/viewemployeelistbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/icunitsassetsviewbloc/icunitsassetsviewbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/newpurchasedropbloc/newpurchasedropbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/addproductbloc/addproductbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/productdeletebloc/productdeletebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/producteditbloc/producteditbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproduct_blocmain/viewproduct_blocmain.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_blocdetailed.dart';
import 'package:parambikulam/bloc/assets/icbloc/removeemployeebloc/removeemployeebloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/repairrequestacceptbloc/repairrequest_blocaccept.dart';
import 'package:parambikulam/bloc/assets/icbloc/viewallemployeebloc/viewallemployeebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/additionalupload/reservationdatafetchebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/haltmarkuploadbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendancedatafetchingbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/datafetchingbloc/markattendenceuploadbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/attentance/employeelistofflinebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/commonsyncbloc/commonsyncbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/commonsyncbloc/commonsynchaltbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/commonsyncbloc/commonuploadattendancebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/deleteibprogrambloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibprogramdeletebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibprogramoffline2bloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibprogramsofflinebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdatauploadbloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdeletebloc.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibreservationdetailsbloc.dart';
import 'package:parambikulam/bloc/assets/new/addassetsmainbloc/addassetsmainbloc.dart';
import 'package:parambikulam/bloc/assets/new/addproductbloc/addproductbloc.dart';
import 'package:parambikulam/bloc/assets/new/assetstransfermainbloc/assetstransfermainbloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewbloc/purchaseviewbloc.dart';
import 'package:parambikulam/bloc/assets/new/purchaseviewdetailedbloc/purchaseviewdetailedbloc.dart';
import 'package:parambikulam/bloc/assets/new/requestmainviewdetailedbloc/requestmainviewdetailedbloc.dart';
import 'package:parambikulam/bloc/assets/new/requestviewmainbloc/requestviewmainbloc.dart';
import 'package:parambikulam/bloc/assets/new/searchassetsidbloc/searchassetsidbloc.dart';
import 'package:parambikulam/bloc/assets/new/sync/sync_icbloc/sync_icbloc.dart';
import 'package:parambikulam/bloc/assets/new/transferstockupdationbloc/transferstock_blocupdation.dart';
import 'package:parambikulam/bloc/assets/new/trasnferwithrequestbloc/transferwithrequest_blocmain.dart';
import 'package:parambikulam/bloc/assets/profilebloc/viewprofilebloc.dart';
import 'package:parambikulam/bloc/assets/profileeditbloc/profieleditevent.dart';
import 'package:parambikulam/bloc/assets/rejectrequestbloc/rejectrequestbloc.dart';
import 'package:parambikulam/bloc/assets/requesttransferbloc/requesttransferbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/requestupdationbloc/requestupdationbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendictoicrequestbloc/sendictoicrequestbloc.dart';
import 'package:parambikulam/bloc/assets/sendrequestbloc/sendrequestbloc.dart';
import 'package:parambikulam/bloc/assets/unitdetailedviewbloc/unitdetailedviewbloc.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestdetailed_bloc/viewrequestdetailed_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestunit_bloc/viewrequest_bloc.dart';
import 'package:parambikulam/bloc/assets/viewrequestunittype_bloc.dart/viewrequestunittype_bloc.dart';
import 'package:parambikulam/bloc/assetsbloc_withoutrequest/assetsbloc_withoutrequest.dart';
import 'package:parambikulam/bloc/auth/auth_bloc.dart';

import 'package:parambikulam/bloc/booking/bookingbloc.dart';
import 'package:parambikulam/bloc/bookingslot/bookingslotbloc.dart';
import 'package:parambikulam/bloc/busbloc/busbloc.dart';
import 'package:parambikulam/bloc/checkinternet/blocinternet.dart';
import 'package:parambikulam/bloc/download/downloadbloc.dart';
import 'package:parambikulam/bloc/entrancecharge/blocentrancecharge.dart';
import 'package:parambikulam/bloc/entrypoint/entranceticketbooking/entranceticketbookingbloc.dart';
import 'package:parambikulam/bloc/entrypoint/entranceuploaddatabloc/entranceuploaddatabloc.dart';
import 'package:parambikulam/bloc/entrypoint/entrybooking/entrybookingbloc.dart';
import 'package:parambikulam/bloc/finalbooking/blocfinalbooking.dart';
import 'package:parambikulam/bloc/imageupload/blocupload.dart';
import 'package:parambikulam/bloc/printticket/blocprintticket.dart';
import 'package:parambikulam/bloc/product/productbloc.dart';
import 'package:parambikulam/bloc/programs/programsbloc.dart';
import 'package:parambikulam/bloc/selectorbloc/blocselector.dart';
import 'package:parambikulam/bloc/syncoffline/blocsyncoffline.dart';
import 'package:parambikulam/bloc/updateguest/blocroomupdateguest.dart';
import 'package:parambikulam/bloc/updateguest/blocupdateguest.dart';
import 'package:parambikulam/bloc/userprofilebloc/blocprofile.dart';
import 'package:parambikulam/bloc/vehicle/blocvehicle.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/ui/app/auth/loginnew.dart';
import 'package:parambikulam/ui/app/entrypoint/entranceticketbooking_guest.dart';
import 'package:parambikulam/ui/app/entrypoint/entrybookinghome.dart';
import 'package:parambikulam/ui/app/random.dart';
import 'package:parambikulam/ui/app/reception_aju/homepage.dart';
import 'package:parambikulam/ui/app/scanner%20&%20ticket/qrscanner.dart';
import 'package:parambikulam/ui/assets/bottombarunits.dart';

import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/bottomnavechoshop.dart';

import 'package:parambikulam/ui/assets/homepages_assets/stays_homepage.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';
import 'package:parambikulam/utils/navigatorservice.dart';

import 'package:parambikulam/utils/pref_manager.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await initializeIbProgramssDataBase();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light, //status bar brigtness
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<BlocProfile>(
              create: (BuildContext context) => BlocProfile()),
          BlocProvider<BlocProfile>(
              create: (BuildContext context) => BlocProfile()),
          BlocProvider<DownloadBloc>(
              create: (BuildContext context) => DownloadBloc()),
          BlocProvider<BusBloc>(create: (BuildContext context) => BusBloc()),
          BlocProvider<BlocPrintTicket>(
              create: (BuildContext context) => BlocPrintTicket()),
          BlocProvider<BlocRoomUpdateGuest>(
              create: (BuildContext context) => BlocRoomUpdateGuest()),
          BlocProvider<BlocAddRoomPerson>(
              create: (BuildContext context) => BlocAddRoomPerson()),
          BlocProvider<BlocAddRoom>(
              create: (BuildContext context) => BlocAddRoom()),
          BlocProvider<LoginBloc>(
              create: (BuildContext context) => LoginBloc()),
          BlocProvider<BlocInternet>(
              create: (BuildContext context) => BlocInternet()),
          BlocProvider<BlocUpdateGuest>(
              create: (BuildContext context) => BlocUpdateGuest()),
          BlocProvider<BlocUpload>(
              create: (BuildContext context) => BlocUpload()),
          BlocProvider<ProgramsBloc>(
            create: (BuildContext context) => ProgramsBloc(),
          ),
          BlocProvider<BookingBloc>(
            create: (BuildContext context) => BookingBloc(),
          ),
          BlocProvider<BookingSlotBloc>(
            create: (BuildContext context) => BookingSlotBloc(),
          ),
          BlocProvider<AddPersonBloc>(
            create: (BuildContext context) => AddPersonBloc(),
          ),
          BlocProvider<BlocVehicle>(
            create: (BuildContext context) => BlocVehicle(),
          ),
          BlocProvider<BlocFinalBooking>(
            create: (BuildContext context) => BlocFinalBooking(),
          ),
          BlocProvider<BlocSyncOffline>(
            create: (BuildContext context) => BlocSyncOffline(),
          ),
          BlocProvider<BlocEntranceCharge>(
            create: (BuildContext context) => BlocEntranceCharge(),
          ),
          BlocProvider<BlocSelectorMain>(
            create: (BuildContext context) => BlocSelectorMain(),
          ),

          ///assets
          ///
          ///
          ///
          BlocProvider<GetViewallAssetsBloc>(
            create: (BuildContext context) => GetViewallAssetsBloc(),
          ),

          BlocProvider<GetEmployeeloginBloc>(
            create: (BuildContext context) => GetEmployeeloginBloc(),
          ),
          BlocProvider<GetViewProfileBloc>(
            create: (BuildContext context) => GetViewProfileBloc(),
          ),

          BlocProvider<GetViewAssetsBloc>(
            create: (BuildContext context) => GetViewAssetsBloc(),
          ),

          BlocProvider<GetViewAssetDetailedsBloc>(
            create: (BuildContext context) => GetViewAssetDetailedsBloc(),
          ),

          BlocProvider<GetAssetsEditDetailedsBloc>(
            create: (BuildContext context) => GetAssetsEditDetailedsBloc(),
          ),
          BlocProvider<GetIcViewUnitsBloc>(
            create: (BuildContext context) => GetIcViewUnitsBloc(),
          ),
          BlocProvider<GetUnitsDetailedViewBloc>(
            create: (BuildContext context) => GetUnitsDetailedViewBloc(),
          ),
          BlocProvider<GetAssetsWithoutRequestBloc>(
            create: (BuildContext context) => GetAssetsWithoutRequestBloc(),
          ),

          BlocProvider<GetViewRequestUnitBloc>(
            create: (BuildContext context) => GetViewRequestUnitBloc(),
          ),
          BlocProvider<GetViewRequestDetailedBloc>(
            create: (BuildContext context) => GetViewRequestDetailedBloc(),
          ),

          BlocProvider<GetRequestRejectBloc>(
            create: (BuildContext context) => GetRequestRejectBloc(),
          ),
          BlocProvider<GetViewRequestUnittypeBloc>(
            create: (BuildContext context) => GetViewRequestUnittypeBloc(),
          ),

          BlocProvider<GetEchoShopSaleBloc>(
            create: (BuildContext context) => GetEchoShopSaleBloc(),
          ),

          BlocProvider<GetTransferRequestBloc>(
            create: (BuildContext context) => GetTransferRequestBloc(),
          ),
          BlocProvider<GetProfileUpdateBloc>(
            create: (BuildContext context) => GetProfileUpdateBloc(),
          ),

          BlocProvider<GetEchoSaleReportBloc>(
            create: (BuildContext context) => GetEchoSaleReportBloc(),
          ),

          BlocProvider<GetSendRequestBloc>(
            create: (BuildContext context) => GetSendRequestBloc(),
          ),
          BlocProvider<GetRequestUpdationBloc>(
            create: (BuildContext context) => GetRequestUpdationBloc(),
          ),
          BlocProvider<GetAddAssetsmainBloc>(
            create: (BuildContext context) => GetAddAssetsmainBloc(),
          ),
          BlocProvider<GetSearchAssetsBloc>(
            create: (BuildContext context) => GetSearchAssetsBloc(),
          ),
          BlocProvider<GetAddProductBloc>(
            create: (BuildContext context) => GetAddProductBloc(),
          ),

          BlocProvider<GetAssetsTransferMainBloc>(
            create: (BuildContext context) => GetAssetsTransferMainBloc(),
          ),

          BlocProvider<GetViewRequestMainBloc>(
            create: (BuildContext context) => GetViewRequestMainBloc(),
          ),

          BlocProvider<GetRequestMainDetailedBloc>(
            create: (BuildContext context) => GetRequestMainDetailedBloc(),
          ),
          BlocProvider<GetViewPurchaseOrderBloc>(
            create: (BuildContext context) => GetViewPurchaseOrderBloc(),
          ),

          BlocProvider<GetViewPurchaseOrderDetailedBloc>(
            create: (BuildContext context) =>
                GetViewPurchaseOrderDetailedBloc(),
          ),

          BlocProvider<GetViewMyRequestDetailedBloc>(
            create: (BuildContext context) => GetViewMyRequestDetailedBloc(),
          ),

          BlocProvider<GetTransferwithRequestBloc>(
            create: (BuildContext context) => GetTransferwithRequestBloc(),
          ),

          BlocProvider<GetNewPurchasedropBloc>(
            create: (BuildContext context) => GetNewPurchasedropBloc(),
          ),
          BlocProvider<GetViewMyRequestBloc>(
            create: (BuildContext context) => GetViewMyRequestBloc(),
          ),

          BlocProvider<ProductBloc>(
            create: (BuildContext context) => ProductBloc(),
          ),
          BlocProvider<GetRepairRequestAcceptBloc>(
            create: (BuildContext context) => GetRepairRequestAcceptBloc(),
          ),
          BlocProvider<GetDamageRequestAcceptBloc>(
            create: (BuildContext context) => GetDamageRequestAcceptBloc(),
          ),
          BlocProvider<GetViewAllEmployeeBloc>(
            create: (BuildContext context) => GetViewAllEmployeeBloc(),
          ),
          BlocProvider<GetEmployeeUnitAssignBloc>(
            create: (BuildContext context) => GetEmployeeUnitAssignBloc(),
          ),
          BlocProvider<GetEmployeeAssignBloc>(
            create: (BuildContext context) => GetEmployeeAssignBloc(),
          ),
          BlocProvider<EntranceTicketBookingBloc>(
            create: (BuildContext context) => EntranceTicketBookingBloc(),
          ),
          BlocProvider<GetIcUnitsassetsviewBloc>(
            create: (BuildContext context) => GetIcUnitsassetsviewBloc(),
          ),

          BlocProvider<GetIcLogmainBloc>(
            create: (BuildContext context) => GetIcLogmainBloc(),
          ),
          BlocProvider<GetRemoveEmployeeBloc>(
            create: (BuildContext context) => GetRemoveEmployeeBloc(),
          ),
          BlocProvider<GetTransferStockUpdationBloc>(
            create: (BuildContext context) => GetTransferStockUpdationBloc(),
          ),
          BlocProvider<GetSendRequestIctoIcBloc>(
            create: (BuildContext context) => GetSendRequestIctoIcBloc(),
          ),
          BlocProvider<GetAddProductMainBloc>(
            create: (BuildContext context) => GetAddProductMainBloc(),
          ),
          BlocProvider<GetViewProductMainBloc>(
            create: (BuildContext context) => GetViewProductMainBloc(),
          ),
          BlocProvider<GetViewProductMainDetailedBloc>(
            create: (BuildContext context) => GetViewProductMainDetailedBloc(),
          ),
          BlocProvider<GetProductMainEditBloc>(
            create: (BuildContext context) => GetProductMainEditBloc(),
          ),
          BlocProvider<GetProductDeleteBloc>(
            create: (BuildContext context) => GetProductDeleteBloc(),
          ),

          BlocProvider<GetIBprogramBloc>(
            create: (BuildContext context) => GetIBprogramBloc(),
          ),

          BlocProvider<GetIBGetHolidaysBloc>(
            create: (BuildContext context) => GetIBGetHolidaysBloc(),
          ),

          BlocProvider<GetIbReservationDetailedsBloc>(
            create: (BuildContext context) => GetIbReservationDetailedsBloc(),
          ),

          BlocProvider<IBProgramdeleteBloc>(
            create: (BuildContext context) => IBProgramdeleteBloc(),
          ),
          BlocProvider<EntryBookingBloc>(
            create: (BuildContext context) => EntryBookingBloc(),
          ),
          BlocProvider<UploadEntryBookingBloc>(
            create: (BuildContext context) => UploadEntryBookingBloc(),
          ),

          BlocProvider<IBReservationdatauploadBloc>(
            create: (BuildContext context) => IBReservationdatauploadBloc(),
          ),

          BlocProvider<Ibreservation2datauploadBloc>(
            create: (BuildContext context) => Ibreservation2datauploadBloc(),
          ),

          BlocProvider<GetIBGetReservationsBloc>(
            create: (BuildContext context) => GetIBGetReservationsBloc(),
          ),

          BlocProvider<GetViewEmployeeListBloc>(
            create: (BuildContext context) => GetViewEmployeeListBloc(),
          ),

          BlocProvider<EmployeelistOfflineBloc>(
            create: (BuildContext context) => EmployeelistOfflineBloc(),
          ),

          BlocProvider<Pendin2OfflineBloc>(
            create: (BuildContext context) => Pendin2OfflineBloc(),
          ),

          BlocProvider<Pendin3OfflineBloc>(
            create: (BuildContext context) => Pendin3OfflineBloc(),
          ),

          BlocProvider<IBReservationdataupload2Bloc>(
            create: (BuildContext context) => IBReservationdataupload2Bloc(),
          ),

          BlocProvider<IBReservationdeleteBloc>(
            create: (BuildContext context) => IBReservationdeleteBloc(),
          ),

          BlocProvider<MarkAttendanceOfflineBloc>(
            create: (BuildContext context) => MarkAttendanceOfflineBloc(),
          ),

          BlocProvider<AttendanceUploadBloc>(
            create: (BuildContext context) => AttendanceUploadBloc(),
          ),

          BlocProvider<GetUploadAttendanceBloc>(
            create: (BuildContext context) => GetUploadAttendanceBloc(),
          ),
          BlocProvider<GetAttendanceReportBloc>(
            create: (BuildContext context) => GetAttendanceReportBloc(),
          ),

          BlocProvider<HaltUploadBloc>(
            create: (BuildContext context) => HaltUploadBloc(),
          ),
          BlocProvider<GetUploadHaltBloc>(
            create: (BuildContext context) => GetUploadHaltBloc(),
          ),

          BlocProvider<GetReportHaltBloc>(
            create: (BuildContext context) => GetReportHaltBloc(),
          ),

          BlocProvider<DeleteIbProgramBloc>(
            create: (BuildContext context) => DeleteIbProgramBloc(),
          ),
          BlocProvider<GetEchoShopProductBloc>(
            create: (BuildContext context) => GetEchoShopProductBloc(),
          ),

          BlocProvider<CommonDatauploadBloc>(
            create: (BuildContext context) => CommonDatauploadBloc(),
          ),

          BlocProvider<CommonHaltUploadBloc>(
            create: (BuildContext context) => CommonHaltUploadBloc(),
          ),

          BlocProvider<CommonAttendanceUploadBloc>(
            create: (BuildContext context) => CommonAttendanceUploadBloc(),
          ),
          BlocProvider<GetEchoShopCartManagementBloc>(
            create: (BuildContext context) => GetEchoShopCartManagementBloc(),
          ),
          BlocProvider<GetEchoShopPlaceOrderBloc>(
            create: (BuildContext context) => GetEchoShopPlaceOrderBloc(),
          ),

          BlocProvider<GetSyncOfflineDataBloc>(
            create: (BuildContext context) => GetSyncOfflineDataBloc(),
          )
        ],
        child: MaterialApp(
          navigatorKey: NavigatorService.navigatorKey,
          // builder: (context, child) {
          //   return MediaQuery(
          //     data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          //     child: child,
          //   );
          // },
          color: AppColors.appColor,
          theme: ThemeData(
            primaryColor: HexColor("#53A874"),
            scaffoldBackgroundColor: HexColor("#1F1F1F"),
            fontFamily: "Sofia Pro",
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
              backgroundColor: HexColor("#141414"),
              // systemOverlayStyle: SystemUiOverlayStyle(
              //     statusBarBrightness: Brightness.light,
              //     statusBarColor: Colors.black),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),

              titleTextStyle: TextStyle(
                fontFamily: "Sofia Pro",
                color: HexColor("#FFFFFF"),
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
              // elevation: 5.0,
              // systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
              centerTitle: false,
              // shadowColor: HexColor("#A8A8A8"),
            ),
            // colorScheme: ColorScheme(background: HexColor("#1F1F1F")),
            // colorScheme: ColorScheme.fromSwatch(
            //   accentColor: Colors.white,
            //   primaryColorDark: Colors.white,
            //   backgroundColor: Colors.white,
            //   primarySwatch: Colors.green,
            // ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            // '/': (context) => BookingSuccess(),
            '/': (context) => NewHome(),
            '/login': (context) => LoginNew(),
            '/home': (context) => HomePage(),
            '/qrScannerPage': (context) => QrScanner(),
            '/RandomPage': (context) => RandomPage(),
          },
        ),
      ),
    );
  }
}

class NewHome extends StatefulWidget {
  _NewHome createState() => _NewHome();
}

class _NewHome extends State<NewHome> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Timer(
      Duration(seconds: 3),
      () => fetcher(),
    );
    // fetcher();

    ///tempararyally closed for assetwork
    ///
    ///very import bloc
    // BlocProvider.of<LoginBloc>(context).add(AuthCheck());
  }

////added for assets
  Future<void> fetcher() async {
    // String? cState = await PrefManager.getCstate();
    bool isLoggedIn = await PrefManager.getIsLoggedIn();
    String? role = await PrefManager.getRole();
    String? token = await PrefManager.getToken();

    if (isLoggedIn && token != null) {
      if (role == "Ecoshop") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => EchoShopBottomNavigation()));
      } else if (role == "Ic") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerBottomNavigation()));
      } else if (role == "Production unit") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UnitsAssetsBottomNavigation()));
      } else if (role == "Ib") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UnitsAssetsBottomNavigation()));
        // MaterialPageRoute(builder: (context) => const IBHomePage()));
      } else if (role == "Stays") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StaysHomePage()));
      } else if (role == "Reception") {
        // bool isConnected = await Helper.checkInternet(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (role == "Entry Point") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => EntryHomePage()));
        //  Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => TestEntryHomePage()));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => UnitsAssetsBottomNavigation()));
      }
    }

    // if (isLoggedIn) {
    //   Timer(
    //       const Duration(seconds: 3),
    //       () => Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => const AssestsHomePage())));
    // }

    else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginNew())));
    }
  }
  // @override
  // void dispose() {
  //   super.dispose();
  //   streamSubscription.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgptrr.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(
              bottom: 100,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "PERIYAR",
                    style: StyleElements.heading,
                  ),
                  Text(
                    "TIGER RESERVE",
                    style: StyleElements.subheading,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: HexColor("#68D389"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     body:  BlocListener<LoginBloc, LoginState>(
    //       listener: (context, state) {
    //         if (state is AuthConfirmed) {
    //           // Navigator.pushReplacementNamed(context, '/home');
    //           Navigator.pushReplacement(context,
    //               MaterialPageRoute(builder: ((context) => SplashScreen())));
    //         } else {
    //           Navigator.pushReplacementNamed(context, '/login');
    //         }
    //       },
    //       child: SizedBox.shrink(),
    //     ),
    //   ),
    // );
  }
}
