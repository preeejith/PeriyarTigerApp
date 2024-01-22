import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:objectid/objectid.dart';
import 'package:parambikulam/bloc/download/downloadbloc.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestviewmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/ic_viewunnitsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/iclogmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/newpurchasedropmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/requestviewmainmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/new/viewallemployeemodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/purchaseorderviewmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/purchaseoredermodel/viewpurchaseordermodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewprofilemodel.dart';
import 'package:parambikulam/data/models/bookingsummary.dart';
import 'package:parambikulam/data/models/busmodel.dart';
import 'package:parambikulam/data/models/echoshopdownloadmodel.dart';
import 'package:parambikulam/data/models/offlinebooking.dart';
import 'package:parambikulam/data/models/packagerate.dart';
import 'package:parambikulam/data/models/programmz.dart';
import 'package:parambikulam/data/models/vehiclemodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final tableprevious = 'previousbookings';
  // late Directory _appDocsDir;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path =
        join(await getDatabasesPath(), "donot_delete_parambikulam.db");
    return await openDatabase(path, version: 1);
  }

  // Future<FutureOr<void>> _onCreate(Database db, int version) async {
  //   print("inside on create");
  //   }

  // createTableIfNot() async {
  //   Database? db = await instance.database;
  //   await db!.execute('''
  //        CREATE TABLE $tableprevious (
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           coverimage TEXT NOT NULL,
  //           progname TEXT NOT NULL,
  //           indian INTEGER,
  //           foreignstudent INTEGER,
  //           bookingdate TEXT NOT NULL,
  //           starttime TEXT NOT NULL,
  //           endtime TEXT NOT NULL
  //           )
  //         ''');
  // }

  Future<int> insert(ProgrammData programData, bool bool, Programmz? programmz,
      [PackageData? packageData]) async {
    Database? db = await instance.database;

    return await db!.insert(
      'allprogramms_seven',
      {
        'dateType': programmz!.dateType,
        'bookingAvailabilityindian':
            programData.bookingAvailability!.indian == true ? "1" : "0",
        'bookingAvailabilityforeigner':
            programData.bookingAvailability!.foreigner == true ? "1" : "0",
        'bookingAvailabilitychildren':
            programData.bookingAvailability!.children == true ? "1" : "0",
        'cottagemaxExtraGuestCount': programData.cottage!.maxExtraGuestCount,
        'cottagemaxExtraIndianCount': programData.cottage!.maxExtraIndianCount,
        'cottagemaxExtraForeignerCount':
            programData.cottage!.maxExtraForeignerCount,
        'cottagemaxExtraChildrenCount':
            programData.cottage!.maxExtraChildrenCount,
        'cottageGuestPerRoom': programData.cottage!.guestPerRoom,

        'cottageMaxTotalGuests': programData.cottage!.guestPerRoom != null
            ? (programData.cottage!.guestPerRoom)! +
                (int.parse(programData.cottage!.maxExtraGuestCount.toString()))
            : 0,
        'cottageMaxTotalIndians': programData.cottage!.guestPerRoom != null
            ? (programData.cottage!.guestPerRoom)! +
                (int.parse(programData.cottage!.maxExtraIndianCount.toString()))
            : 0,
        'cottageMaxTotalForeigners': programData.cottage!.guestPerRoom != null
            ? (programData.cottage!.guestPerRoom)! +
                (int.parse(
                    programData.cottage!.maxExtraForeignerCount.toString()))
            : 0,
        'cottageMaxTotalChildren': programData.cottage!.guestPerRoom != null
            ? (programData.cottage!.guestPerRoom)! +
                (int.parse(
                    programData.cottage!.maxExtraChildrenCount.toString()))
            : 0,

        'started': programData.started == true ? "1" : "0",
        'isCottage': programData.isCottage == true ? "1" : "0",
        'progName': programData.progName,
        'idstring': programData.id,
        'coverImage': programData.coverImage,
        'minGuest': programData.minGuest,
        'maxGuest': programData.maxGuest,
        'maxAge': programData.maxAge,
        'minAge': programData.minAge,
        'reportingTime': programData.reportingTime,
        'rules': programData.rules,
        'caption': programData.caption,
        'startPoint': programData.startPoint,
        'endPoint': programData.endPoint,
        'duration': programData.duration,
        'category': programData.category,

        //null below
        'pWindianAdult': bool
            ? packageData!.weekendPackage != null
                ? packageData.weekendPackage!.windianAdult
                : null
            : null,
        // 'pWindianAdult': bool ? packageData!.weekendPackage!.windianAdult : null,
        'pWindianStudent': bool
            ? packageData!.weekendPackage != null
                ? packageData.weekendPackage!.windianStudent
                : null
            : null,
        'pWforeignAdult': bool
            ? packageData!.weekendPackage != null
                ? packageData.weekendPackage!.wforeignAdult
                : null
            : null,
        'pWforeignStudent': bool
            ? packageData!.weekendPackage != null
                ? packageData.weekendPackage!.wforeignStudent
                : null
            : null,
        'pWbonafiedStudent': bool
            ? packageData!.weekendPackage != null
                ? packageData.weekendPackage!.wbonafiedStudent
                : null
            : null,
        'pHindianAdult':
            bool ? packageData!.holydaysPackage!.hindianAdult : null,
        'pHindianStudent':
            bool ? packageData!.holydaysPackage!.hindianStudent : null,
        'pHforeignAdult':
            bool ? packageData!.holydaysPackage!.hforeignAdult : null,
        'pHforeignStudent':
            bool ? packageData!.holydaysPackage!.hforeignStudent : null,
        'pHbonafiedStudent':
            bool ? packageData!.holydaysPackage!.hbonafiedStudent : null,
        'pHchildren': bool ? packageData!.holydaysPackage!.hchildren : null,
        'pHforeigner': bool ? packageData!.holydaysPackage!.hforeigner : null,
        'pHindian': bool ? packageData!.holydaysPackage!.hindian : null,
        'pEindianAdult':
            bool ? packageData!.extraperheadPackage!.eindianAdult : null,
        'pEindianStudent':
            bool ? packageData!.extraperheadPackage!.eindianStudent : null,
        'pEforeignAdult':
            bool ? packageData!.extraperheadPackage!.eforeignAdult : null,
        'pEforeignStudent':
            bool ? packageData!.extraperheadPackage!.eforeignStudent : null,
        'pEbonafiedStudent':
            bool ? packageData!.extraperheadPackage!.ebonafiedStudent : null,
        'pEchildren': bool ? packageData!.extraperheadPackage!.echildren : null,
        'pEforeigner':
            bool ? packageData!.extraperheadPackage!.eforeigner : null,
        'pEindian': bool ? packageData!.extraperheadPackage!.eindian : null,
        'isExtraPerHeadAvailable':
            bool ? packageData!.isExtraPerHeadAvailable : null,
        //  pNchildren INTEGER,roomCount
        // pNforeigner INTEGER,
        // pNindian INTEGER,
        'pNindian': bool ? packageData!.indian : 0,
        'pNforeigner': bool ? packageData!.foreigner : 0,
        'pNchildren': bool ? packageData!.children : 0,
      },
    );

    // var imageName =
    //     programmz.coverImage!.substring(0, programmz.coverImage!.indexOf('.'));
    // final response = await http
    //     .get(Uri.parse(WebClient.imageIp + programmz.coverImage.toString()));
    // final documentDirectory = await getApplicationDocumentsDirectory();
    // final file = File(join(documentDirectory.path, imageName + ".jpg"));
    // file.writeAsBytesSync(response.bodyBytes);
    // File newFile = await Directory.systemTemp
    // Database? db = _database;

    // var fileName =
    //     programmz.coverImage!.substring(0, programmz.coverImage!.indexOf('.'));
    // String path = join(_appDocsDir.path, fileName);
  }

  deleteTables() async {
    try {
      Database? db = await instance.database;
      await db!.execute('DROP TABLE IF EXISTS tbl_terms_and_conditions_one');
      await db.execute('DROP TABLE IF EXISTS allprogramms_seven');
      await db.execute('DROP TABLE IF EXISTS table_booking_five');
      await db.execute('DROP TABLE IF EXISTS table_tickets_eight');
      await db.execute('DROP TABLE IF EXISTS previousBookingsUpdate');
      await db.execute('DROP TABLE IF EXISTS slotdetails_table_two');
      await db.execute('DROP TABLE IF EXISTS tbl_bus_details');
      await db.execute('DROP TABLE IF EXISTS bus_allocation');
      await db.execute('DROP TABLE IF EXISTS allotedTickets_bus');
      //
      //
    } catch (e) {
      print("TABLE DELETION EXCEPTION OCCURED");
      print("+++++++++++++++++++++++++++++++++++++++");
      print('----------------------------------------');
      print(e);
      print('----------------------------------------');
      print("+++++++++++++++++++++++++++++++++++++++");
    }
  }

  Future<List<ProgrammData>> queryAllRows() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> allProgramms =
        await db!.query('allprogramms_seven');

    return List.generate(allProgramms.length, (index) {
      return ProgrammData(
        progName: allProgramms[index]['progName'],
        coverImage: allProgramms[index]['coverImage'],
        id: allProgramms[index]['idstring'],
        started: allProgramms[index]['started'] == "1" ? true : false,
        status: allProgramms[index]['status'],
        isCottage: allProgramms[index]['isCottage'] == "1" ? true : false,
      );
      // return ProgrammData(
      //   coverImage: allProgramms[index]['']
      // );
    });
  }

  querySpecificRow(String? programId) async {
    try {
      Database? db = await instance.database;
      final List<Map<String, dynamic>> specProDetails = await db!.rawQuery(
          "select * from allprogramms_seven where idstring = '$programId'");
      return List.generate(specProDetails.length, (index) {
        print(
          "the status is + " + specProDetails[index]['started'],
        );
        return ProgrammData(
          progName: specProDetails[index]['progName'],
          coverImage: specProDetails[index]['coverImage'],
          started: specProDetails[index]['started'] == "1" ? true : false,
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Future queryAllRowsOne(String? programId) async {
    Database? db = await instance.database;
    //  'SELECT * FROM package_tbl_one WHERE idString = "$programId"');
    List<Map> detailsList = await db!.query(
      "allprogramms_seven",
      where: "progName = ?",
      whereArgs: ['$programId'],
    );
    detailsList.forEach((element) {
      print(element);
    });
    return detailsList;

    // List<Map> list = await db!.query(
    //   'package_tbl_one',
    // );
    // list.forEach((row) => print(row));
    // await db!.query('package_tbl_one');
    // await db!.query('package_tbl');
    // return List.generate(programDetails.length, (index) {
    //   return PackageRate(
    //       data: Data(
    //     coverImage: programDetails[index]['coverImage'],
    //     progName: programDetails[index]['progName'],
    //   ));
    // });
  }

  Future<int> insertToPackageTable(PackageRate packageRate, String s) async {
    print("inserting ${packageRate.data!.progName}");
    var count;
    bool isPack = packageRate.package!.length == 1 ? true : false;
    Database? db = await instance.database;
    count = await db!.insert(s, {
      'bAIndian': packageRate.data!.bookingAvailability!.indian,
      'bAForeigner': packageRate.data!.bookingAvailability!.foreigner,
      'bAChildren': packageRate.data!.bookingAvailability!.children,
      'coverImage': packageRate.data!.coverImage,
      'progName': packageRate.data!.progName,
      'started': packageRate.data!.started == true ? 1 : 0,
      'isCottage': packageRate.data!.isCottage,
      'hIndian': isPack ? packageRate.package![0].holidays!.indian : 0,
      'hForeigner': isPack ? packageRate.package![0].holidays!.foreigner : 0,
      'hChildren': isPack ? packageRate.package![0].holidays!.children : 0,
      'eChildren': isPack ? packageRate.package![0].extraperhead!.children : 0,
      'eForeigner':
          isPack ? packageRate.package![0].extraperhead!.foreigner : 0,
      'eIndian': isPack ? packageRate.package![0].extraperhead!.indian : 0,
      // 'wIndian': isPack ? packageRate.package![0].weekend!.indianAdult : 0,
      // 'wForeigner': isPack ? packageRate.package![0].weekend!.foreignAdult : 0,
      'programme': isPack ? packageRate.package![0].programme : 0,
      'idString': isPack ? packageRate.package![0].sId : 0,
    });

    return count != null ? count : 0;
  }

  Future<List<Map<String, dynamic>>> queryAllRowsPackages() async {
    Database? db = await instance.database;
    return await db!.query('package_tbl');
  }

  checkAndCreateTable(String s) async {
    try {
      Database? db = await instance.database;
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS $s (
            id INTEGER PRIMARY KEY AUTOINCREMENT,

            bAIndian BIT,
            bAForeigner BIT,
            bAChildren BIT,

            coverImage TEXT,
            progName TEXT,
            programId TEXT,

            started BIT,
            isCottage BIT,

            hIndian INTEGER,
            hForeigner INTEGER,
            hChildren INTEGER,

            eIndian INTEGER,
            eForeigner INTEGER,
            eChildren INTEGER,

            wIndian INTEGER,
            wForeigner INTEGER,

            programme TEXT,
            idString TEXT,

            FOREIGN KEY (programme) REFERENCES allprogramms_four(idstring)
          )
          ''');
    } catch (e) {}
  }

  tableBookingSummary(String s) async {
    try {
      Database? db = await instance.database;
      return await db!.execute('''
      CREATE TABLE IF NOT EXISTS $s(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         progName TEXT,
         startTime TEXT,
         endTime TEXT,
         freeCount TEXT,
         idString TEXT,
         bAIndian TEXT,
         bAForeigner TEXT,
         bAChildren TEXT,
      )
      ''');
    } catch (e) {}
  }

  addSlotDeatails(BookingSummaryData data, String tableName) async {
    Database? db = await instance.database;
    return await db!.insert(tableName, {
      'statusOne': data.endTime,
      'statusTwo': data.slot!.statusOne,
      'idStringOne': data.id,
      'idStringTwo': data.slot!.idOne,
      'programme': data.slot!.programme,
      'fromDate': data.slot!.fromDate,
      'toDate': data.slot!.toDate,
      'slotType': data.slot!.slotType,
      'startTime': data.startTime,
      'endTime': data.endTime,
      'availableNo': data.availableNo,
      'freeCount': data.freeCount,
      'bookedCount': data.bookedCount,
      'selected': 0,
    });
  }

  // checkAndCreateSlotTable(String tableName) async {
  //   try {
  //     Database? db = await instance.database;
  //     return await db!.execute('''
  //     CREATE TABLE IF NOT EXISTS $tableName(
  //        id INTEGER PRIMARY KEY AUTOINCREMENT,
  //        statusOne BIT,
  //        statusTwo BIT,
  //        isSelected BIT,
  //        idStringOne TEXT,
  //        idStringTwo TEXT,
  //        programme TEXT,
  //        fromDate TEXT,
  //        toDate TEXT,
  //        slotType TEXT,
  //        startTime TEXT,
  //        selected BIT,
  //        endTime TEXT,
  //        availableNo INTEGER,
  //        freeCount INTEGER,
  //        bookedCount INTEGER,
  //        FOREIGN KEY (programme) REFERENCES allprogramms_five(idstring)
  //     )
  //     ''');
  //   } catch (e) {}
  // }

  getSlotData(String tableName, String? programId) async {
    Database? db = await instance.database;
    List<Map> detailsList = await db!.query(
      tableName,
      where: "programme = ?",
      whereArgs: ['$programId'],
    );
    // list.forEach((row) => print(row));
    return detailsList;
  }

  // clearSlotTable(String s) async {
  //   try {
  //     Database? db = await instance.database;
  //     await db!.delete(s);
  //     // await db.update(s,
  //     // });
  //     // await db.execute("alter table $s auto_increment = 1");
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  getProgramData(String tableName, String? progName) async {
    Database? db = await instance.database;
    List<Map> programList = await db!.query(
      tableName,
      where: "progName = ?",
      whereArgs: ['$progName'],
    );
    programList.forEach((row) => print(row));
    return programList;
  }

  getSlotDetails(String? slotId) async {
    Database? db = await instance.database;
    print("program id $slotId");
    List<Map> slotList = await db!.query(
      'slotdetails_table_two',
      where: "idStringOne = ?",
      whereArgs: ['$slotId'],
    );
    return slotList;
  }

  checkAndCreateBookingTable(String tableName) async {
    // try {
    Database? db = await instance.database;
    await db!.execute('''
          CREATE TABLE IF NOT EXISTS $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            programId TEXT
          )
          ''');
    // } catch (e) {}
  }

  addToVehicleTable(VehicleModel vehicleModel) async {
    Database? db = await instance.database;
    try {
      return await db!.insert('table_vaahan', {
        'entranceTicketCharge': vehicleModel.data!.lightVehicleCharge,
        'lightVehicleCharge': vehicleModel.data!.lightVehicleCharge,
        'heavyVehicleCharge': vehicleModel.data!.heavyVehicleCharge,
        'indianEntranceCharge': vehicleModel.data!.indianEntranceCharge,
        'foreignerEntraneCharge': vehicleModel.data!.foreignerEntraneCharge,
        'childrenEntraneCharge': vehicleModel.data!.childrenEntraneCharge,
        'camera': vehicleModel.data!.camera,
        'moviecamera': vehicleModel.data!.moviecamera,
        'tax': vehicleModel.data!.tax,
        '_id': vehicleModel.data!.id,
      });
    } catch (e) {
      print(e);
    }
  }

  addToBusTable(BusData data, ObjectId tripId) async {
    Database? db = await instance.database;
    try {
      return await db!.insert('tbl_bus_details', {
        'idOne': data.sId,
        'idTwo': data.busDetails!.sId,
        'busId': data.busDetails!.busId,
        'tripId': tripId.toString(),
        'tripCount': '1',
        'regNO': data.busDetails!.regNo,
        'noOfSeats': data.busDetails!.noOfSeats,
        'noOfSeatsDummy': data.busDetails!.noOfSeats,
        'isActive': data.busDetails!.status,
        'busName': data.busDetails!.busName,
      });
    } catch (e) {
      print(e);
    }
  }

  getBusDataInitial() async {
    Database? db = await instance.database;
    try {
      var data = await db!.query('tbl_bus_details');
      print(data);
    } catch (e) {
      print(e);
    }
  }

  // addToBusAllocationTable(BusData data, ObjectId tripId) async {
  //   Database? db = await instance.database;
  //   try {
  //     return await db!.insert('bus_allocation', {
  //       'busId': data.busDetails!.busId,
  //       'isActive': 'true',
  //       'tripId': tripId.toString(),
  //       'tripCount': 0
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // createVehicleTable() async {
  //   Database? db = await instance.database;
  //   try {
  //     return await db!.execute('''
  //         CREATE TABLE IF NOT EXISTS table_vaahan (
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           entranceTicketCharge INTEGER,
  //           lightVehicleCharge INTEGER,
  //           heavyVehicleCharge INTEGER,
  //           indianEntranceCharge INTEGER,
  //           foreignerEntraneCharge INTEGER,
  //           childrenEntraneCharge INTEGER,
  //           camera INTEGER,
  //           moviecamera INTEGER,
  //           tax INTEGER,
  //           _id TEXT
  //         )
  //         ''');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  getVehicleInformation() async {
    Database? db = await instance.database;
    List<Map> slotList = await db!.query('table_vaahan');
    return slotList;
  }

  //Entry Ticket DB

  addEntryBookingData(String? offlineBooking, String? ticketId) async {
    await checkAndCreateEntryBookingTable();
    Database? db = await instance.database;
    try {
      return await db!.insert('table_entry_booking', {
        'ticketId': ticketId,
        'bookingData': offlineBooking,
      });
    } catch (e) {
      print(e);
    }
  }

  checkAndCreateEntryBookingTable() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS table_entry_booking (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ticketId TEXT,
            bookingData TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  checkAndCreateEchoShopDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS table_echo_download (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  checkAndCreateEchoShopSalesReport() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS echoshop_salesreports (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            isEmployee TEXT, status TEXT,_id TEXT,unitId TEXT,employeeId TEXT,totalAmount TEXT,create_date TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  checkAndCreateEchoShopSalesDetailedReport() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS echoshop_salesreportdetailed(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            status TEXT, _id TEXT,saleId TEXT,stockId TEXT,quantity TEXT,salesPrice TEXT,discount TEXT,create_date TEXT,itemName TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addEchoData(String? data) async {
    await checkAndCreateEchoShopDownloads();
    Database? db = await instance.database;
    await db!.delete("table_echo_download");
    try {
      return await db.insert('table_echo_download', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  addEchoSalesReport(Map value) async {
    await checkAndCreateEchoShopSalesReport();
    Database? db = await instance.database;
    value['index'] == "0" ? await db!.delete("echoshop_salesreports") : "";
    try {
      return await db!.rawInsert(
          'INSERT INTO echoshop_salesreports(isEmployee,status,_id,unitId,employeeId,totalAmount,create_date) VALUES(?,?,?,?,?,?,?)',
          [
            value['isEmployee'],
            value['status'],
            value['_id'],
            value['unitId'],
            value['employeeId'],
            value['totalAmount'],
            value['create_date'],
          ]);
    } catch (e) {
      print(e);
    }
  }

  addEchoSalesDetaileddeleteallReport() async {
    Database? db = await instance.database;

    try {
      return await db!.delete("echoshop_salesreportdetailed");
    } catch (e) {
      print(e);
    }
  }

  addEchoSalesDetailedReport(Map value) async {
    await checkAndCreateEchoShopSalesDetailedReport();
    Database? db = await instance.database;
    // value['index'] == "0"
    //     ? await db!.delete("echoshop_salesreportdetailed")
    //     : "";
    try {
      return await db!.rawInsert(
          'INSERT INTO echoshop_salesreportdetailed(status,_id,saleId,stockId,quantity,salesPrice,discount,create_date,itemName) VALUES(?,?,?,?,?,?,?,?,?)',
          [
            value['status'],
            value['_id'],
            value['saleId'],
            value['stockId'],
            value['quantity'],
            value['salesPrice'],
            value['discount'],
            value['create_date'],
            value['itemName'],
          ]);
    } catch (e) {
      print(e);
    }
  }

  getEchoDownloadData() async {
    await checkAndCreateEchoShopDownloads();
    Database? db = await instance.database;

    final EchoShopProductDownloadModel echoShopProductDownloadModel =
        EchoShopProductDownloadModel.fromJson(jsonDecode(
            ((await db!.query("table_echo_download"))[0]['data'].toString())));

    return echoShopProductDownloadModel;
  }

  getEchoSalesReportData() async {
    await checkAndCreateEchoShopSalesReport();
    List items = [];

    Database? db = await instance.database;
    final _values = await db!.query("echoshop_salesreports");

    for (var map in _values) {
      items.add(map);
    }
    print(items);
    return items;
  }

  getEchoSalesReportDetailfulldata() async {
    await checkAndCreateEchoShopSalesDetailedReport();
    List salesdetailedlist = [];

    Database? db = await instance.database;

    final _values = await db!.query("echoshop_salesreportdetailed");

    for (var map in _values) {
      salesdetailedlist.add(map);
    }
    print(salesdetailedlist);
    return salesdetailedlist;
  }

  getEchoSalesReportDetailedData(salesid) async {
    await checkAndCreateEchoShopSalesDetailedReport();
    // List salesdetailedlist = [];

    Database? db = await instance.database;

    List<Map> salesdetailedlist = await db!.query(
      "echoshop_salesreportdetailed",
      where: "saleId = ?",
      whereArgs: ['$salesid'],
    );
    // final _values = await db!.query("echoshop_salesreportdetailed");

    // for (var map in _values) {
    //   salesdetailedlist.add(map);
    // }
    print(salesdetailedlist);
    return salesdetailedlist;
  }

  /////ic_//////start
  ///profile/////
  checkAndCreateICProfileDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS profileview (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addIBProfileViewData(String? data) async {
    await checkAndCreateICProfileDownloads();
    Database? db = await instance.database;
    await db!.delete("profileview");
    try {
      return await db.insert('profileview', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getIbProfileDownloadData() async {
    await checkAndCreateICProfileDownloads();
    Database? db = await instance.database;

    final ViewProfileModel viewProfileModel = ViewProfileModel.fromJson(
        jsonDecode(((await db!.query("profileview"))[0]['data'].toString())));
    // print(viewProfileModel.status);
    return viewProfileModel;
  }

///////newpurchase dropdown
  checkAndCreateNewPurDropDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS newpurchasedrop (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addNewPurDropViewData(String? data) async {
    await checkAndCreateNewPurDropDownloads();
    Database? db = await instance.database;
    await db!.delete("newpurchasedrop");
    try {
      return await db.insert('newpurchasedrop', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getNewPurDropDownloadData() async {
    await checkAndCreateNewPurDropDownloads();
    Database? db = await instance.database;

    final NewPurchaseDropModel newPurchaseDropModel =
        NewPurchaseDropModel.fromJson(jsonDecode(
            ((await db!.query("newpurchasedrop"))[0]['data'].toString())));
    print(newPurchaseDropModel.status);
    return newPurchaseDropModel;
  }

////////requestview production uits
  ///
  checkAndCreateUnitsRequestViewDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS unitsrequestview (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addUnitsRequestViewData(String? data) async {
    await checkAndCreateUnitsRequestViewDownloads();
    Database? db = await instance.database;
    await db!.delete("unitsrequestview");
    try {
      return await db.insert('unitsrequestview', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getUnitsRequestViewDownloadData() async {
    await checkAndCreateUnitsRequestViewDownloads();
    Database? db = await instance.database;

    final MyRequestViewModel myRequestViewModel = MyRequestViewModel.fromJson(
        jsonDecode(
            ((await db!.query("unitsrequestview"))[0]['data'].toString())));
    print(myRequestViewModel.status);
    return myRequestViewModel;
  }

  ////////purchase items
  ///
  ///
  ///
  checkAndCreateICPurchaseListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS purchaselist (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICPurchaseListdata(String? data) async {
    await checkAndCreateICPurchaseListDownloads();
    Database? db = await instance.database;
    await db!.delete("purchaselist");
    try {
      return await db.insert('purchaselist', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICPurchaseListDownloadData() async {
    await checkAndCreateICPurchaseListDownloads();
    Database? db = await instance.database;

    final ViewPurchaseListModel viewPurchaseListModel =
        ViewPurchaseListModel.fromJson(jsonDecode(
            ((await db!.query("purchaselist"))[0]['data'].toString())));
    print(viewPurchaseListModel.status);
    return viewPurchaseListModel;
  }

  /////asset
  ///
  checkAndCreateICassetsListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS assetslist (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

///////
  addICAssetsListdata(String? data) async {
    await checkAndCreateICassetsListDownloads();
    Database? db = await instance.database;
    await db!.delete("assetslist");
    try {
      return await db.insert('assetslist', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICAssetsListDownloadData() async {
    await checkAndCreateICassetsListDownloads();
    Database? db = await instance.database;

    final ViewAllAssetsModel viewAllAssetsModel = ViewAllAssetsModel.fromJson(
        jsonDecode(((await db!.query("assetslist"))[0]['data'].toString())));
    // print(viewAllAssetsModel.status);
    return viewAllAssetsModel;
  }

  ////////view all assets new table

  checkAndCreateViewAssetsDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS assetsview (
            idno INTEGER PRIMARY KEY AUTOINCREMENT,
            quantity TEXT,assetid TEXT,name TEXT,price TEXT,
             discount TEXT,status TEXT,id TEXT,checkon TEXT,
             createDate TEXT,unitId TEXT,edited TEXT,added TEXT,
             assetidtaken TEXT,purchaseid TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

///////create section for all
  addViewAssetsdata(ViewassetsModel? viewassetsModel) async {
    await checkAndCreateViewAssetsDownloads();
    Database? db = await instance.database;
    // await db!.delete("assetsview");
    try {
      print("hello");
      return await db!.insert('assetsview', viewassetsModel!.toJson());
    } catch (e) {
      print(e);
    }
  }

  deleteViewAssetsdata() async {
    await checkAndCreateViewAssetsDownloads();
    Database? db = await instance.database;
    await db!.delete("assetsview");
  }

  getViewAssetsDownloadData() async {
    await checkAndCreateViewAssetsDownloads();
    Database? db = await instance.database;

    final _values = await db!.rawQuery('SELECT * FROM assetsview');
    print(_values);
    List<ViewassetsModel> list = [];

    for (var map in _values) {
      final range = ViewassetsModel.fromJson(map);
      list.add(range);
    }
    return list;
  }

  ///for update value in assets view
  updateassetsdata(name, edited, id) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        'UPDATE assetsview SET name = ?,edited=? WHERE assetid= ?',
        [name.toString(), edited, id]);
  }

  ///edit quantirty of assets
  ///
  ///
  ///

//for update data of newly added data
  updatenewassetsdata(name, edited, id) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        'UPDATE assetsview SET added = ?,assetidtaken=? WHERE assetid= ?',
        [name.toString(), edited, id]);
  }

//////
  ////for edit quantity
  updateassetsquantitydata(totalquantity, id) async {
    Database? db = await instance.database;
    print("updated");
    await db!.rawUpdate('UPDATE assetsview SET quantity = ? WHERE assetid= ?',
        [totalquantity.toString(), id]);
  }

  ///for taking the quantity
  getassetquantityDownloadData(id) async {
    await checkAndCreateViewAssetsDownloads();
    Database? db = await instance.database;

    final _values =
        await db!.rawQuery('SELECT * FROM assetsview WHERE assetid=?', [id]);
    print(_values);
    List<ViewassetsModel> list = [];

    for (var map in _values) {
      final range = ViewassetsModel.fromJson(map);
      list.add(range);
    }
    return list[0];
  }

  ////asset Master table
  ///
  checkAndCreateAssetMasterTableDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS assetmastertable (
            idno INTEGER PRIMARY KEY AUTOINCREMENT,
            status TEXT,id TEXT,name TEXT,productType TEXT, description TEXT,create_date TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addViewAssetMasterTabledata(AssetMasterTable? assetMasterTable) async {
    await checkAndCreateAssetMasterTableDownloads();
    Database? db = await instance.database;
    // await db!.delete("assetmastertable");
    try {
      print("hello");
      return await db!.insert('assetmastertable', assetMasterTable!.toJson());
    } catch (e) {
      print(e);
    }
  }

  updateassetsdescriptiondata(remark, id) async {
    Database? db = await instance.database;
    print("updated");
    await db!.rawUpdate(
        'UPDATE assetmastertable SET description = ? WHERE id= ?',
        [remark.toString(), id]);
  }

  updateassetmasterdata(name, description, id) async {
    Database? db = await instance.database;
    await db!.rawUpdate(
        'UPDATE assetmastertable SET name = ?,description=? WHERE id= ?',
        [name.toString(), description, id]);
  }

  deleteViewAssetMasterTabledata() async {
    await checkAndCreateAssetMasterTableDownloads();
    Database? db = await instance.database;
    await db!.delete("assetmastertable");
  }

//new
  getAssetMasterTableDownloadData() async {
    await checkAndCreateAssetMasterTableDownloads();
    Database? db = await instance.database;

    final _values = await db!.rawQuery('SELECT * FROM assetmastertable');
    // print(_values);
    List<AssetMasterTable> list = [];

    for (var map in _values) {
      final range = AssetMasterTable.fromJson(map);
      list.add(range);
    }
    return list;
  }

  ////for purchase model
  ///
  ///attendance22222
  checkAndCreatePurchaseassetsDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS purchaseassetsdata (
            idno INTEGER PRIMARY KEY AUTOINCREMENT,
            status TEXT,id TEXT,employeeId TEXT,purchaseId TEXT,assetId TEXT,assetname TEXT, totalAmount TEXT,discount TEXT, billAmount TEXT,create_date TEXT,quantity TEXT,purchaseAmount TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addPurchaseassetsdata(PurchaseOrder? purchaseOrder) async {
    await checkAndCreatePurchaseassetsDownloads();
    Database? db = await instance.database;
    // await db!.delete("assetmastertable");
    try {
      // print("purchase22");
      return await db!.insert('purchaseassetsdata', purchaseOrder!.toJson());
    } catch (e) {
      print(e);
    }
  }

  deletePurchaseassetsdata() async {
    await checkAndCreatePurchaseassetsDownloads();
    Database? db = await instance.database;
    await db!.delete("purchaseassetsdata");
    try {
      // print("hello");
      return await db.delete("purchaseassetsdata");
    } catch (e) {
      print(e);
    }
  }

  getPurchaseassetsDownloadData() async {
    await checkAndCreatePurchaseassetsDownloads();
    Database? db = await instance.database;

    final _values = await db!.rawQuery('SELECT * FROM purchaseassetsdata');
    print(_values);
    List<PurchaseOrder> list = [];

    for (var map in _values) {
      final range = PurchaseOrder.fromJson(map);
      list.add(range);
    }
    return list;
  }

  ///purchase data remaining
  ///

  checkAndCreatePurchasedataDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS purchasedata (
            idno INTEGER PRIMARY KEY AUTOINCREMENT,
            purchaseid TEXT,name TEXT,purchaseAmount TEXT,quantity TEXT,assetId TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addPurchasedata(PurchaseData? purchaseData) async {
    await checkAndCreatePurchasedataDownloads();
    Database? db = await instance.database;
    // await db!.delete("assetmastertable");
    try {
      // print("purchase ok");
      return await db!.insert('purchasedata', purchaseData!.toJson());
    } catch (e) {
      print(e);
    }
  }

  deletePurchasedata() async {
    await checkAndCreatePurchasedataDownloads();
    Database? db = await instance.database;
    await db!.delete("purchasedata");
    try {
      await db.delete("purchasedata");
    } catch (e) {
      print(e);
    }
  }

  getPurchasedataDownloadData() async {
    await checkAndCreatePurchasedataDownloads();
    Database? db = await instance.database;

    final _values = await db!.rawQuery('SELECT * FROM purchasedata');
    print(_values);
    List<PurchaseData> list = [];

    for (var map in _values) {
      final range = PurchaseData.fromJson(map);
      list.add(range);
    }
    return list;
  }
////IC LOGs
  ///

  checkAndCreateICLOGListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS iclogs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICLOGListdata(String? data) async {
    await checkAndCreateICLOGListDownloads();
    Database? db = await instance.database;
    await db!.delete("iclogs");
    try {
      return await db.insert('iclogs', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICLOGListDownloadData() async {
    await checkAndCreateICLOGListDownloads();
    Database? db = await instance.database;

    final IcLogModel icLogModel = IcLogModel.fromJson(
        jsonDecode(((await db!.query("iclogs"))[0]['data'].toString())));
    print(icLogModel.status);
    return icLogModel;
  }

/////employ asssign
  ///
  checkAndCreateEmployeeListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS employeelist (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICEmployeeListdata(String? data) async {
    await checkAndCreateEmployeeListDownloads();
    Database? db = await instance.database;
    await db!.delete("employeelist");
    try {
      return await db.insert('employeelist', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICEmployeeListDownloadData() async {
    await checkAndCreateEmployeeListDownloads();
    Database? db = await instance.database;

    final ViewAllEmployeeModel viewAllEmployeeModel =
        ViewAllEmployeeModel.fromJson(jsonDecode(
            ((await db!.query("employeelist"))[0]['data'].toString())));
    // print(viewAllEmployeeModel.status);
    return viewAllEmployeeModel;
  }

//////unitview
  ///
  checkAndCreateUnitsListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS unitslist (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICUnitsListdata(String? data) async {
    await checkAndCreateUnitsListDownloads();
    Database? db = await instance.database;
    await db!.delete("unitslist");
    try {
      return await db.insert('unitslist', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICUnitsListDownloadData() async {
    await checkAndCreateUnitsListDownloads();
    Database? db = await instance.database;

    final IcViewUnitsModel icViewUnitsModel = IcViewUnitsModel.fromJson(
        jsonDecode(((await db!.query("unitslist"))[0]['data'].toString())));
    print(icViewUnitsModel.status);
    return icViewUnitsModel;
  }

  ////////requestview
  ///
  checkAndCreateRequestViewListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS requestview (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICRequestViewListdata(String? data) async {
    await checkAndCreateRequestViewListDownloads();
    Database? db = await instance.database;
    await db!.delete("requestview");
    try {
      return await db.insert('requestview', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICRequestViewListDownloadData() async {
    await checkAndCreateRequestViewListDownloads();
    Database? db = await instance.database;

    final ViewRequestMainModel viewRequestMainModel =
        ViewRequestMainModel.fromJson(jsonDecode(
            ((await db!.query("requestview"))[0]['data'].toString())));
    print(viewRequestMainModel.status);
    return viewRequestMainModel;
  }

/////request offline
  //////////
  ///
  checkAndCreateRequestOfflineListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS masterviewtable2 (
            idno INTEGER PRIMARY KEY AUTOINCREMENT,
            typeOfRequest TEXT,untiId TEXT,unitName TEXT,date TEXT,status TEXT,id TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICRequestOfflineListdata(String? data) async {
    await checkAndCreateRequestOfflineListDownloads();
    Database? db = await instance.database;
    await db!.delete("masterviewtable2");
    try {
      return await db.insert('masterviewtable2', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICRequestOfflineListDownloadData() async {
    await checkAndCreateRequestOfflineListDownloads();
    Database? db = await instance.database;

    final ViewRequestMainModel viewRequestMainModel =
        ViewRequestMainModel.fromJson(jsonDecode(
            ((await db!.query("masterviewtable2"))[0]['data'].toString())));
    print(viewRequestMainModel.status);
    return viewRequestMainModel;
  }

  //
/////employeeassign
  ///
  checkAndCreateEmployeeAssignListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS employeeassign (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICEmployeeAssignListdata(String? data) async {
    await checkAndCreateEmployeeAssignListDownloads();
    Database? db = await instance.database;
    // await db!.delete("employeeassign");
    try {
      return await db!.insert('employeeassign', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  ///hi
  getICEmployeeeAssignListDownloadData() async {
    await checkAndCreateEmployeeAssignListDownloads();
    Database? db = await instance.database;

    List items24 = [];

    final _values = await db!.query('employeeassign');

    for (var map in _values) {
      items24.add(map);
    }
    return items24;
  }

  /////
  Future<void> deleteICEmployeeAssignListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM employeeassign WHERE id = ?', [index]);
  }

  ///repair accept
  checkAndrepairacceptedacceptedListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS repairaccepted (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICrepairacceptedListdata(String? data) async {
    await checkAndrepairacceptedacceptedListDownloads();
    Database? db = await instance.database;
    // await db!.delete("employeeassign");
    try {
      return await db!.insert('repairaccepted', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  ///hi
  getICrepairacceptedListDownloadData() async {
    await checkAndrepairacceptedacceptedListDownloads();
    Database? db = await instance.database;

    List items62 = [];

    final _values = await db!.query('repairaccepted');

    for (var map in _values) {
      items62.add(map);
    }
    return items62;
  }

  /////
  Future<void> deleteICrepairacceptedListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM repairaccepted WHERE id = ?', [index]);
  }

////damage accepted
  ///
  ///
  ///
  ///
  checkAndCreateDamageacceptedListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS damageaccepted (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICDamageacceptedListdata(String? data) async {
    await checkAndCreateDamageacceptedListDownloads();
    Database? db = await instance.database;
    // await db!.delete("employeeassign");
    try {
      return await db!.insert('damageaccepted', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  ///hi
  getICDamageacceptedListDownloadData() async {
    await checkAndCreateDamageacceptedListDownloads();
    Database? db = await instance.database;

    List items33 = [];

    final _values = await db!.query('damageaccepted');

    for (var map in _values) {
      items33.add(map);
    }
    return items33;
  }

  /////
  Future<void> deleteICDamageacceptedListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM damageaccepted WHERE id = ?', [index]);
  }

//////assets edit
  checkAndCreateAssetsEditListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS assetsedit (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICAssetsEditListdata(String? data) async {
    await checkAndCreateAssetsEditListDownloads();
    Database? db = await instance.database;
    // await db!.delete("employeeassign");
    try {
      return await db!.insert('assetsedit', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  ///hi
  getICAssetsEditListDownloadData() async {
    await checkAndCreateAssetsEditListDownloads();
    Database? db = await instance.database;

    List items32 = [];

    final _values = await db!.query('assetsedit');

    for (var map in _values) {
      items32.add(map);
    }
    return items32;
  }

  /////
  Future<void> deleteICAssetsEditListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM assetsedit WHERE id = ?', [index]);
  }

/////////newrequestto ic to ic
  ///
  checkAndCreateICICRequestListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS icicrequest (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICICICRequestListdata(String? data) async {
    await checkAndCreateICICRequestListDownloads();
    Database? db = await instance.database;
    // await db!.delete("employeeassign");
    try {
      return await db!.insert('icicrequest', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  ///hi
  getICICICRequestListDownloadData() async {
    await checkAndCreateICICRequestListDownloads();
    Database? db = await instance.database;

    List items29 = [];

    final _values = await db!.query('icicrequest');

    for (var map in _values) {
      items29.add(map);
    }
    return items29;
  }

  /////
  Future<void> deleteICICICRequestListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM icicrequest WHERE id = ?', [index]);
  }

////////employee remove form  assigned list
  ///
  checkAndCreateEmployeeAssigndelListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS employeeassigndel (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICEmployeeAssigndelListdata(String? data) async {
    await checkAndCreateEmployeeAssigndelListDownloads();
    Database? db = await instance.database;
    // await db!.delete("employeeassigndel");
    try {
      return await db!.insert('employeeassigndel', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICEmployeeAssigndelListDownloadData() async {
    await checkAndCreateEmployeeAssigndelListDownloads();
    Database? db = await instance.database;

    List items28 = [];

    final _values = await db!.query('employeeassigndel');

    for (var map in _values) {
      items28.add(map);
    }
    return items28;
  }

  Future<void> deleteICEmployeeAssigndelListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM employeeassigndel WHERE id = ?', [index]);
  }

  ///////stockupdation transfer//
  checkAndCreateStockUpdateTransferListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS stockupdatetransfer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICStockUpdateTransferListdata(String? data) async {
    await checkAndCreateStockUpdateTransferListDownloads();
    Database? db = await instance.database;
    // await db!.delete("stockupdatetransfer");
    try {
      return await db!.insert('stockupdatetransfer', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  ///
//stock updation
  getICStockUpdateTransferListDownloadData() async {
    await checkAndCreateStockUpdateTransferListDownloads();
    Database? db = await instance.database;

    List items25 = [];

    final _values = await db!.query('stockupdatetransfer');

    for (var map in _values) {
      items25.add(map);
    }
    return items25;
  }

  Future<void> deleteICStockUpdateTransferListdata(index) async {
    Database? db = await instance.database;
    await db!
        .rawDelete('DELETE FROM stockupdatetransfer WHERE id = ?', [index]);
  }

  ///////////////////
  ///trasfer damage repair and  new request

  checkAndCreateNewRequestTransferListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS newpurchasetransfer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

////no
  addICNewRequestTransferListdata(String? data) async {
    await checkAndCreateNewRequestTransferListDownloads();
    Database? db = await instance.database;
    // await db!.delete("stockupdatetransfer");
    try {
      return await db!.insert('newpurchasetransfer', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

//new trer
  getICNewRequestTransferListDownloadData() async {
    await checkAndCreateNewRequestTransferListDownloads();
    Database? db = await instance.database;

    List items26 = [];

    final _values = await db!.query('newpurchasetransfer');

    for (var map in _values) {
      items26.add(map);
    }
    return items26;
  }

  Future<void> deleteICNewRequestTransferListdata(index) async {
    Database? db = await instance.database;
    await db!
        .rawDelete('DELETE FROM newpurchasetransfer WHERE id = ?', [index]);
  }

  /////assests transfer////
  checkAndCreateAssetsTransferListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS assetstransfer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICAssetsTransferListdata(String? data) async {
    await checkAndCreateAssetsTransferListDownloads();
    Database? db = await instance.database;
    // await db!.delete("assetstransfer");

    try {
      return await db!.insert('assetstransfer', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

/////main
  getICAssetsTrasnferListDownloadData() async {
    await checkAndCreateAssetsTransferListDownloads();
    Database? db = await instance.database;

    List items23 = [];

    final _values = await db!.query('assetstransfer');

    for (var map in _values) {
      items23.add(map);
    }
    return items23;
  }

  Future<void> deletgetICAssetsTrasnferList(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM assetstransfer WHERE id = ?', [index]);
  }

//////to reduce the  count of quantity
  checkAndCreateAssetsTransferCountListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS assetstransfercount (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            assetid TEXT, quantity TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICAssetsTransferCountListdata(String? data) async {
    await checkAndCreateAssetsTransferCountListDownloads();
    Database? db = await instance.database;

    try {
      return await db!.insert('assetstransfercount', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICAssetsTrasnferCountListDownloadData() async {
    await checkAndCreateAssetsTransferCountListDownloads();
    Database? db = await instance.database;

    List items34 = [];

    final _values = await db!.query('assetstransfercount');

    for (var map in _values) {
      items34.add(map);
    }
    return items34;
  }

  Future<void> deletgetICAssetsTrasnferCountList(index) async {
    Database? db = await instance.database;
    await db!
        .rawDelete('DELETE FROM assetstransfercount WHERE id = ?', [index]);
  }

//////add assets
  ///
  ///
  checkAndCreateAddAssetsListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS addassets (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  ///ultimatehelper
  addICAddAssetsListdata(String? data) async {
    await checkAndCreateAddAssetsListDownloads();
    Database? db = await instance.database;
    // await db!.delete("addassets");
    try {
      return await db!.insert('addassets', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICAddAssetsListDownloadData() async {
    await checkAndCreateAddAssetsListDownloads();
    Database? db = await instance.database;
    List items21 = [];
    // final data = (((await db!.query("addassets")).toString()));
    // print(data['transferedtoId']);
    // return data;
    final _values = await db!.query('addassets');

    for (var map in _values) {
      items21.add(map);
    }
    return items21;
  }

  Future<void> deletealldata2(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM addassets WHERE id = ?', [index]);
  }

  //////request sending other units
  ///
  checkAndCreateRequestSendingListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS requestsending (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICRequestSendingListdata(String? data) async {
    await checkAndCreateRequestSendingListDownloads();
    Database? db = await instance.database;
    // await db!.delete("requestsending");
    try {
      return await db!.insert('requestsending', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICRequestSendingListDownloadData() async {
    await checkAndCreateRequestSendingListDownloads();
    Database? db = await instance.database;

    List items31 = [];

    final _values = await db!.query('requestsending');

    for (var map in _values) {
      items31.add(map);
    }
    return items31;
  }

  Future<void> delICRequestSendingListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM requestsending WHERE id = ?', [index]);
  }

  //////unitnewrequest
  checkAndCreateUnitNewRequestListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS unitnewrequest (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addUnitNewRequestListdata(String? data) async {
    await checkAndCreateUnitNewRequestListDownloads();
    Database? db = await instance.database;
    // await db!.delete("unitnewrequest");
    try {
      return await db!.insert('unitnewrequest', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getUnitNewRequestListDownloadData() async {
    await checkAndCreateUnitNewRequestListDownloads();
    Database? db = await instance.database;

    List items29 = [];

    final _values = await db!.query('unitnewrequest');

    for (var map in _values) {
      items29.add(map);
    }
    return items29;

    // final data =
    //     jsonDecode(((await db!.query("unitnewrequest"))[0]['data'].toString()));
    // // print(data['transferedtoId']);
    // return data;
  }

  Future<void> delUnitNewRequestListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM unitnewrequest WHERE id = ?', [index]);
  }
//////employee assiign in units
  ///ultimatehelper

///////////////
  checkAndCreateUnitsAssignListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS unitsassign (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

//yes
  addICUnitsAssignListdata(String? data) async {
    await checkAndCreateUnitsAssignListDownloads();
    Database? db = await instance.database;
    // await db!.delete("unitsassign");
    try {
      return await db!.insert('unitsassign', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICUnitsAssignListDownloadData() async {
    await checkAndCreateUnitsAssignListDownloads();
    Database? db = await instance.database;
    List items22 = [];

    final _values = await db!.query('unitsassign');

    for (var map in _values) {
      items22.add(map);
    }
    return items22;
  }

  Future<void> getICUnitsAssigndeleteListDownloadData(index) async {
    Database? db = await instance.database;
    // await db!.delete("unitsassign");
    await db!.rawDelete('DELETE FROM unitsassign WHERE id = ?', [index]);
  }

/////add edit product
  ///
  checkAndCreateAddProductEditListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS productedit2 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICAddProductEditListdata(String? data) async {
    await checkAndCreateAddProductEditListDownloads();
    Database? db = await instance.database;
    // await db!.delete("addproduct");
    try {
      return await db!.insert('productedit2', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICAddProductEditListDownloadData() async {
    await checkAndCreateAddProductEditListDownloads();
    Database? db = await instance.database;

    List items69 = [];

    final _values = await db!.query('productedit2');

    for (var map in _values) {
      items69.add(map);
    }
    return items69;
  }

  // final data =
  //     jsonDecode(((await db!.query("addproduct"))[0]['data'].toString()));
  // // print(data['transferedtoId']);
  // return data;

  Future<void> deleteICAddProductEditListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM productedit2 WHERE id = ?', [index]);
  }
////////addproduct///
  ///
  ///

  checkAndCreateAddProductListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS addproduct (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICAddProductListdata(String? data) async {
    // await checkAndCreateAddProductListDownloads();
    Database? db = await instance.database;
    // await db!.delete("addproduct");
    try {
      return await db!.insert('addproduct', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICAddProductListDownloadData() async {
    await checkAndCreateAddProductListDownloads();
    Database? db = await instance.database;

    List items27 = [];

    final _values = await db!.query('addproduct');

    for (var map in _values) {
      items27.add(map);
    }
    return items27;
  }

  // final data =
  //     jsonDecode(((await db!.query("addproduct"))[0]['data'].toString()));
  // // print(data['transferedtoId']);
  // return data;

  Future<void> deleteICAddProductListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM addproduct WHERE id = ?', [index]);
  }
  /////addproductimage coverimage

  checkAndCreateAddProductImgListDownloads() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS addproductimg (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addICAddProductImgListdata(String? data) async {
    await checkAndCreateAddProductImgListDownloads();
    Database? db = await instance.database;
    // await db!.delete("addproductimg");
    try {
      return await db!.insert('addproductimg', {
        'data': data,
      });
    } catch (e) {
      print(e);
    }
  }

  getICAddProductImgListDownloadData() async {
    await checkAndCreateAddProductImgListDownloads();
    Database? db = await instance.database;

    return await db!.query('addproductimg');

    // final data =
    //     jsonDecode(((await db!.query("addproductimg"))[0]['data'].toString()));
    // print(data);
    // // print(data['images'][0]['image'].toString());
    // return data;
  }

////
  Future<void> deleteICAddProductImgListdata(index) async {
    Database? db = await instance.database;
    await db!.rawDelete('DELETE FROM addproductimg WHERE id = ?', [index]);
  }
///////ic

  getEntryBookingDataOne(tableId) async {
    await checkAndCreateEntryBookingTable();
    Database? db = await instance.database;
    List<Map> detailsList = await db!.query(
      "table_entry_booking",
      where: "ticketId = ?",
      whereArgs: ['$tableId'],
    );
    return detailsList;
  }

  getEntryBookingData() async {
    await checkAndCreateEntryBookingTable();
    Database? db = await instance.database;
    //  await checkAndCreateEntryBookingTable();
    List<Map> detailsList = await db!.query("table_entry_booking");
    return detailsList;
  }

  deleteOneEntryTicket(ticketid) async {
    await checkAndCreateEntryBookingTable();
    Database? db = await instance.database;
    await db!.delete(
      "table_entry_booking",
      where: "ticketId = ?",
      whereArgs: ['$ticketid'],
    );
  }

  addBookingData(
      OfflineBooking? offlineBooking, String? ticketId, String? busId) async {
    // await checkAndCreateFinalBookingTable();
    Database? db = await instance.database;
    String members = json.encode(offlineBooking!.members);
    String vehicleList = json.encode(offlineBooking.vehicleList);
    String newListTwo = json.encode(offlineBooking.newListTwo);
    String data = json.encode(offlineBooking.data);
    String entranceData = json.encode(offlineBooking.entranceData);
    print(members + " -- " + vehicleList + " -- " + newListTwo);
    try {
      return await db!.insert('table_booking_five', {
        'programId': offlineBooking.programId,
        'slotId': offlineBooking.slotId,
        'busId': busId,
        'bookingDate': offlineBooking.bookingDate,
        'title': offlineBooking.title,
        'indianCount': offlineBooking.indianCount,
        'childrenCount': offlineBooking.childrenCount,
        'foreignerCount': offlineBooking.foreignerCount,
        'roomCount': offlineBooking.roomCount,
        'data': data,
        'totalAmount': offlineBooking.totalAmount,
        'indianTotal': offlineBooking.indianTotal,
        'foreignerTotal': offlineBooking.foreignerTotal,
        'childrenTotal': offlineBooking.childrenTotal,
        'entranceTicket': entranceData,
        'members': members,
        'vehicle': vehicleList,
        'newListTwo': newListTwo,
        'ticketId': ticketId,
        'startTime': offlineBooking.startTime,
        'endTime': offlineBooking.endTime,
        'guestLength': offlineBooking.freeCount,
      });
    } catch (e) {
      print(e);
    }
  }

  // checkAndCreateFinalBookingTable() async {
  //   Database? db = await instance.database;
  //   try {
  //     return await db!.execute('''
  //         CREATE TABLE IF NOT EXISTS table_booking_five (
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           programId TEXT,
  //           slotId TEXT,
  //           bookingDate TEXT,
  //           title TEXT,
  //           indianCount INTEGER,
  //           childrenCount INTEGER,
  //           foreignerCount INTEGER,
  //           totalAmount INTEGER,
  //           indianTotal INTEGER,
  //           roomcount INTEGER,
  //           foreignerTotal INTEGER,
  //           childrenTotal INTEGER,
  //           ticketNumber INTEGER,
  //           entranceTicket TEXT,
  //           members TEXT,
  //           data TEXT,
  //           vehicle TEXT,
  //           newListTwo TEXT,
  //           ticketId TEXT,
  //           startTime TEXT,
  //           endTime TEXT,
  //           guestLength INTEGER,
  //           reason TEXT
  //         )
  //         ''');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  updateSlotTable(int? totalMembers, String? slotId, String? programId) async {
    print('updating table');
    Database? db = await instance.database;
    try {
      await db!.rawUpdate(
          'UPDATE slotdetails_table_two SET freeCount = ? WHERE idStringOne = ?',
          [totalMembers, slotId]);
    } catch (e) {
      print(e);
    }
  }

  addTicketId(String qrId, OfflineBooking? offlineBooking) async {
    print("updating ticketid");
    Database? db = await instance.database;
    try {
      return await db!.rawUpdate(
          'UPDATE table_booking_five SET ticketId = ? WHERE programId = ?',
          [qrId, offlineBooking!.programId.toString()]);
    } catch (e) {
      print(e);
    }
  }

  addTicketNumber(OfflineBooking? offlineBooking, ticketNumber) async {
    print("updating ticketnumber");
    Database? db = await instance.database;
    try {
      return await db!.rawUpdate(
          'UPDATE table_booking_five SET ticketNumber = ? WHERE id = ?',
          [ticketNumber, offlineBooking!.tableId.toString()]);
    } catch (e) {
      //  print("database exception in adding ticket number $e");
    }
  }

  updateReason(String? msg, int tableId) async {
    print("updating ticketid");
    Database? db = await instance.database;
    try {
      return await db!.rawUpdate(
          'UPDATE table_booking_five SET reason = ? WHERE id = ?',
          [msg, tableId]);
    } catch (e) {
      print("database exception in adding ticket number $e");
    }
  }

  getBookingData(int? tableId) async {
    Database? db = await instance.database;
    List<Map> detailsList = await db!.query(
      "table_booking_five",
      where: "id = ?",
      whereArgs: ['$tableId'],
    );
    return detailsList;
  }

  getFinalBookingData() async {
    Database? db = await instance.database;
    List<Map> detailsList = await db!.query("table_booking_five");
    // kn
    return detailsList;
  }

  getFinalFailedBookingData() async {
    Database? db = await instance.database;
    List<Map> detailsList = await db!.query(
      "table_booking_five",
      where: "reason IS NULL",
    );
    // kn
    return detailsList;
  }

  // Future<void> checkAndCreateTermsAndCondions() async {
  //   try {
  //     Database? db = await instance.database;
  //     return await db!.execute('''
  //         CREATE TABLE IF NOT EXISTS tbl_terms_and_conditions_one(
  //           id INTEGER PRIMARY KEY,
  //           canValue TEXT,
  //           tcValue TEXT,
  //           ticketNumber INTEGER
  //         )
  //         ''');
  //   } catch (e) {
  //     print("db exception $e");
  //   }
  // }

  addIntialTerms(tcValue, cValue, tNumber) async {
    Database? db = await instance.database;
    return await db!.insert('tbl_terms_and_conditions_one', {
      'canValue': cValue.toString(),
      'tcValue': tcValue.toString(),
      'ticketNumber': tNumber.toString()
    });
  }

  // updateTerms(
  //   tcValue,
  //   cValue,
  // ) async {
  //   Database? db = await instance.database;
  //   return await db!.rawUpdate(
  //       'UPDATE tbl_terms_and_conditions_one SET canValue = ?, tcValue = ? WHERE id = ?',
  //       [cValue, tcValue, 1]);
  // }

  getTermsAndConditionsOffline() async {
    Database? db = await instance.database;
    return await db!.query('tbl_terms_and_conditions_one');
  }

  // checkIfExists() async {
  //   var result;
  //   try {
  //     Database? db = await instance.database;
  //     var result = await db!.query('sqlite_master',
  //         where: 'name = ?', whereArgs: ['tbl_terms_and_conditions_one']);
  //     return result;
  //   } catch (_) {
  //     return result;
  //   }
  // }

  updateTicket(int i) async {
    Database? db = await instance.database;
    try {
      await db!.rawUpdate(
          'UPDATE tbl_terms_and_conditions_one SET ticketNumber = ? WHERE id = ?',
          [i, 1]);
    } catch (e) {
      print(e);
    }
  }

  // checkAndCreateRoomCountTable() async {
  //   //'roomcount_table'
  //   try {
  //     Database? db = await instance.database;
  //     return await db!.execute('''
  //         CREATE TABLE IF NOT EXISTS roomcount_table (
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           refId INTEGER,
  //           indianCount INTEGER,
  //           foreignerCount INTEGER,
  //           childrenCount INTEGER,
  //           FOREIGN KEY (refId) REFERENCES table_booking_five(id)
  //         )
  //         ''');
  //   } catch (e) {
  //     print("db exception $e");
  //   }
  // }

  deleteFromBookings(int tableId) async {
    try {
      Database? db = await instance.database;
      return await db!
          .rawDelete('DELETE FROM table_booking_five WHERE id = ?', [tableId]);
    } catch (e) {
      print("db exception $e");
    }
  }

  deleteFromPreviousUpdates(int tableId) async {
    try {
      Database? db = await instance.database;
      return await db!.rawDelete(
          'DELETE FROM previousBookingsUpdate WHERE id = ?', [tableId]);
    } catch (e) {
      print("db exception $e");
    }
  }

  // checAndCreateTicketTable() async {
  //   Database? db = await instance.database;
  //   try {
  //     return await db!.execute('''
  //         CREATE TABLE IF NOT EXISTS table_tickets_eight (
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           ticketNo INTEGER,
  //           ticket TEXT,
  //           localTicket TEXT,
  //           ticketDetails TEXT,
  //           mainProgramme TEXT,
  //           vehicles TEXT,
  //           entranceTickets TEXT
  //         )
  //         ''');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  insertToTicketTable(
      BuildContext context,
      String ticketDetailsString,
      mainProgramme,
      tickNo,
      ticket,
      ticketApp,
      vehicles,
      entranceTickets) async {
    Database? db = await instance.database;
    context.read<DownloadBloc>().add(AddingTicketof(ticketNumber: tickNo));
    return await db!.insert('table_tickets_eight', {
      'ticketNo': tickNo,
      'ticket': ticket,
      'localTicket': ticketApp,
      'ticketDetails': ticketDetailsString,
      'vehicles': vehicles,
      'mainProgramme': mainProgramme,
      'entranceTickets': entranceTickets,
    });
  }

  getTicketFromLocal(String parse) async {
    Database? db = await instance.database;
    return await db!.query(
      "table_tickets_eight",
      where: "ticketNo = ?",
      whereArgs: ['$parse'],
    );
  }

  getFromQr(String qr) async {
    Database? db = await instance.database;
    print(await db!.query('table_tickets_eight'));
    return await db.query(
      "table_tickets_eight",
      where: "ticket = ? OR localTicket = ?",
      whereArgs: ['$qr', '$qr'],
    );
  }

  getAllTickets() async {
    Database? db = await instance.database;
    return await db!.query(
      "table_tickets_eight",
      // where: "ticketNo = ?",
      // whereArgs: ['$s'],
    );
  }

  // createTablePreviousBookingsUpdate() async {
  //   Database? db = await instance.database;
  //   try {
  //     return await db!.execute('''
  //         CREATE TABLE IF NOT EXISTS previousBookingsUpdate (
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           personId TEXT,
  //           ticketId TEXT,
  //           imageFile TEXT
  //         )
  //         ''');
  //   } catch (e) {}
  // }

  updateTablePreviousBookingsUpdate(
      param2, String? path, String? ticket) async {
    Database? db = await instance.database;
    try {
      return await db!.update('previousBookingsUpdate',
          {'personId': param2, 'ticketId': ticket, 'imageFile': path});
    } catch (e) {}
  }

  getSpecificPreviousBookingsUpdate(param2) async {
    Database? db = await instance.database;
    try {
      return await db!.query(
        "previousBookingsUpdate",
        where: "personId = ?",
        whereArgs: ['$param2'],
      );
    } catch (e) {}
  }

  getAllPreviousBookingsUpdate() async {
    Database? db = await instance.database;
    return await db!.query('previousBookingsUpdate');
  }

  insertTablePreviousBookingsUpdate(
      personId, String? path, String? ticketId) async {
    Database? db = await instance.database;
    try {
      return await db!.insert('previousBookingsUpdate',
          {'personId': personId, 'ticketId': ticketId, 'imageFile': path});
    } catch (e) {}
  }

  // updateImage(guestId, String? path) async {
  //   Database? db = await instance.database;
  //   // return await db!.update('table_tickets_eight', {
  //   //   'ticketNo': tickNo,
  //   //   'ticket': ticket,
  //   //   'ticketDetails': ticketDetailsString,
  //   //   'vehicles': vehicles,
  //   //   'mainProgramme': mainProgramme,
  //   //   'entranceTickets': entranceTickets,
  //   // });
  //    await db!.rawUpdate(
  //         'UPDATE table_tickets_eight SET freeCount = ? WHERE idStringOne = ?',
  //         [totalMembers, slotId]);
  // }

  // insertToSummaryTable(BookingSummary bookingSummary, String tableName) async {
  //   Database? db = await instance.database;
  //   var count;
  //   count = await db!.insert(tableName, {
  //     'endTime': bookingSummary.data![0].endTime,
  //     'freeCount': bookingSummary.data![0].freeCount,
  //     'idString': bookingSummary.data![0].id,
  //     'selected': bookingSummary.data![0].selected,
  //     'startTime': bookingSummary.data![0].startTime,
  //     'progName': bookingSummary.programData!.progName,
  //     'bAIndian': bookingSummary.programData!.progName,
  //   });

  //   return count;
  // }

  //placerorder
  checkAndCreatePlaceOrderData() async {
    Database? db = await instance.database;
    try {
      return await db!.execute('''
          CREATE TABLE IF NOT EXISTS table_echo_place_order (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId TEXT,
            data TEXT
          )
          ''');
    } catch (e) {
      print(e);
    }
  }

  addPlaceorderData(String? data) async {
    await checkAndCreatePlaceOrderData();
    Database? db = await instance.database;

    try {
      return await db!.insert('table_echo_place_order',
          {'data': data, 'orderId': ObjectId().toString()});
    } catch (e) {
      print(e);
    }
  }

  getPlaceorderData() async {
    await checkAndCreatePlaceOrderData();
    Database? db = await instance.database;

    return await db!.query("table_echo_place_order");
  }

  deleteCartData() async {
    await checkAndCreatePlaceOrderData();
    Database? db = await instance.database;

    return await db!.delete("table_echo_place_order");
  }

  deleteOneCartData(orderid) async {
    await checkAndCreateEntryBookingTable();
    Database? db = await instance.database;
    await db!.delete(
      "table_echo_place_order",
      where: "orderId = ?",
      whereArgs: ['$orderid'],
    );
  }

  createTables() async {
    try {
      Database? db = await instance.database;
      await db!.execute('''
          CREATE TABLE allprogramms_seven (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            bookingAvailabilityindian TEXT,
            bookingAvailabilityforeigner TEXT,
            bookingAvailabilitychildren TEXT,
            cottagemaxExtraGuestCount INTEGER,
            cottagemaxExtraIndianCount INTEGER,
            cottagemaxExtraForeignerCount INTEGER,
            cottagemaxExtraChildrenCount INTEGER,
            cottageGuestPerRoom INTEGER,
            cottageMaxTotalGuests INTEGER,
            cottageMaxTotalIndians INTEGER,
            cottageMaxTotalForeigners INTEGER,
            cottageMaxTotalChildren INTEGER,
            started TEXT,
            isCottage TEXT,
            idstring TEXT,
            status TEXT,
            progName TEXT,
            coverImage TEXT,
            description TEXT,TEXT,

            minGuest INTEGER,
            maxGuest INTEGER,
            maxAge INTEGER,
            minAge INTEGER,
            reportingTime TEXT,
            rules TEXT,
            caption TEXT,

            startPoint TEXT,
            endPoint TEXT,
            duration INTEGER,

            category TEXT,

            pWindianAdult INTEGER,
            pWindianStudent INTEGER,
            pWforeignAdult INTEGER,
            pWforeignStudent INTEGER,
            pWbonafiedStudent INTEGER,

            pHindianAdult INTEGER,
            pHindianStudent INTEGER,
            pHforeignAdult INTEGER,
            pHforeignStudent INTEGER,
            pHbonafiedStudent INTEGER,
            pHchildren INTEGER,
            pHforeigner INTEGER,
            pHindian INTEGER,

            pEindianAdult INTEGER,
            pEindianStudent INTEGER,
            pEforeignAdult INTEGER,
            pEforeignStudent INTEGER,
            pEbonafiedStudent INTEGER,
            pEchildren INTEGER,
            pEforeigner INTEGER,
            pEindian INTEGER,

            isExtraPerHeadAvailable BIT,

            _id TEXT,
            fromDate TEXT,
            toDate TEXT,
            programme TEXT,

            pNindianAdult INTEGER,
            pNindianStudent INTEGER,
            pNforeignAdult INTEGER,
            pNforeignStudent INTEGER,
            pNbonafiedStudent INTEGER,
            pNchildren INTEGER,
            pNforeigner INTEGER,
            pNindian INTEGER,

            dateType TEXT

          )
          ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS slotdetails_table_two(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         statusOne BIT,
         statusTwo BIT,
         isSelected BIT,
         idStringOne TEXT,
         idStringTwo TEXT,
         programme TEXT,
         fromDate TEXT,
         toDate TEXT,
         slotType TEXT,
         startTime TEXT,
         selected BIT,
         endTime TEXT,
         availableNo INTEGER,
         freeCount INTEGER,
         bookedCount INTEGER,
         FOREIGN KEY (programme) REFERENCES allprogramms_five(idstring)
      )
      ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS roomcount_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            refId INTEGER,
            indianCount INTEGER,
            foreignerCount INTEGER,
            childrenCount INTEGER,
            FOREIGN KEY (refId) REFERENCES table_booking_five(id)
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS table_vaahan (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            entranceTicketCharge INTEGER,
            lightVehicleCharge INTEGER,
            heavyVehicleCharge INTEGER,
            indianEntranceCharge INTEGER,
            foreignerEntraneCharge INTEGER,
            childrenEntraneCharge INTEGER,
            camera INTEGER,
            moviecamera INTEGER,
            tax INTEGER,
            _id TEXT
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS table_booking_five (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            programId TEXT,
            slotId TEXT,
            bookingDate TEXT,
            title TEXT,
            indianCount INTEGER,
            childrenCount INTEGER,
            foreignerCount INTEGER,
            totalAmount INTEGER,
            indianTotal INTEGER,
            roomcount INTEGER,
            foreignerTotal INTEGER,
            childrenTotal INTEGER,
            ticketNumber INTEGER,
            entranceTicket TEXT,
            members TEXT,
            data TEXT,
            vehicle TEXT,
            newListTwo TEXT,
            busId TEXT,
            tripId TEXT,
            ticketId TEXT,
            startTime TEXT, 
            endTime TEXT,
            guestLength INTEGER,
            reason TEXT
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS table_tickets_eight (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ticketNo INTEGER, 
            ticket TEXT,
            localTicket TEXT,
            ticketDetails TEXT,
            mainProgramme TEXT,
            vehicles TEXT,
            entranceTickets TEXT
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS previousBookingsUpdate (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            personId TEXT,
            ticketId TEXT,
            imageFile TEXT
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS tbl_terms_and_conditions_one(
            id INTEGER PRIMARY KEY,
            canValue TEXT,
            tcValue TEXT,
            ticketNumber INTEGER
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS tbl_bus_details(
            id INTEGER PRIMARY KEY,
            idOne TEXT,
            idTwo TEXT,
            busId TEXT,
            isActive TEXT,
            regNO TEXT,
            tripId TEXT,
            tripCount TEXT,
            noOfSeats INTEGER,
            noOfSeatsDummy INTEGER,
            busName TEXT,
            ticketNumber INTEGER
          )
          ''');
      await db.execute('''
          CREATE TABLE IF NOT EXISTS bus_allocation(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tripId TEXT,
            tripCount TEXT,
            busName TEXT,
            ticketId TEXT,
            noOfPassengers TEXT,
            timestamp TEXT,
            busId TEXT,
            isActive TEXT
            )
          ''');
      // await db.execute('''
      //     CREATE TABLE IF NOT EXISTS bus_allocation(
      //       id INTEGER PRIMARY KEY AUTOINCREMENT,
      //       tripCount INTEGER,
      //       busId TEXT,
      //       isActive TEXT,
      //       tripId TEXT,
      //       trips TEXT
      //     )
      //     ''');
      // await db.execute('''
      //     CREATE TABLE IF NOT EXISTS allotedTickets_bus(
      //       id INTEGER PRIMARY KEY AUTOINCREMENT,
      //       ticketId TEXT,
      //       numberOfMembers TEXT,
      //       referenceId INTEGER,
      //       FOREIGN KEY(referenceId) REFERENCES bus_allocation(id)
      //     )
      //     ''');
    } catch (e) {
      print("TABLE CREATION EXCEPTION OCCURED ---- $e");
      print("+++++++++++++++++++++++++++++++++++++++");
      print('----------------------------------------');
      print(e);
      print('----------------------------------------');
      print("+++++++++++++++++++++++++++++++++++++++");
    }
  }

  updateBusData(index, String updation) async {
    Database? db = await instance.database;
    return await db!.rawUpdate(
        'UPDATE tbl_bus_details SET isActive = ? WHERE id= ?',
        [updation, index + 1]);
  }

  // updateBusAllocation(String? busId, String status) async {
  //   Database? db = await instance.database;
  //   return await db!.rawUpdate(
  //       'UPDATE bus_allocation SET isActive = ? WHERE busId= ?',
  //       [status, busId]);
  // }

  updateBusAllocationOne(BusData busData, data, String? ticketName) async {
    try {
      Database? db = await instance.database;
      return await db!.insert('allotedTickets_bus', {
        'ticketId': ticketName,
        'numberOfMembers': busData.busDetails!.noOfPassengers,
        'referenceId': data,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  getData() async {
    Database? db = await instance.database;
    return await db!.query('allotedTickets_bus');
  }

  // getBusId(String? busId) async {
  //   Database? db = await instance.database;
  //   return await db!
  //       .rawQuery('SELECT * FROM bus_allocation WHERE busId=?', [busId]);
  // }

  // queryAllocation() async {
  //   Database? db = await instance.database;
  //   return await db!.query('bus_allocation');
  // }
  //updateBusAllocation

  getBusDataFirst(index) async {
    Database? db = await instance.database;
    var busData = await db!
        .rawQuery('SELECT * FROM tbl_bus_details WHERE id=${index + 1}');
    return busData;
  }

  queryAllBusRows() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> busData =
        await db!.query('tbl_bus_details');

    return List.generate(busData.length, (index) {
      print('tripcount ${busData[index]['tripCount']}');
      return BusData(
        sId: busData[index]['idOne'],
        busDetails: BusDetails(
          tickets: [],
          sId: busData[index]['idTwo'],
          busId: busData[index]['busId'],
          noOfSeatsDummy: busData[index]['noOfSeatsDummy'],
          status: busData[index]['isActive'],
          tripId: busData[index]['tripId'],
          tripCount: int.parse(busData[index]['tripCount']),
          regNo: busData[index]['regNO'],
          noOfSeats: busData[index]['noOfSeats'],
          busName: busData[index]['busName'],
        ),
      );
    });
  }

  getBusFinalData() async {
    // Database? db = await instance.database;
    List mainList = [];
    List list = await getAllocationData();
    // print(list);

    for (int index = 0; index < list.length; index++) {
      var tripId = list[index]['tripId'];
      var tripCount = list[index]['tripCount'];
      if (mainList.where((element) => element['tripId'] == tripId).isEmpty &&
          mainList
              .where((element) => element['tripCount'] == tripCount)
              .isEmpty) {
        mainList.add({
          "tripId": list[index]['tripId'],
          "tripCount": list[index]['tripCount'],
          "busId": list[index]['busId'],
          "busName": list[index]['busName'],
          "isActive": 'true',
          "noOfPassengers": getNoPassengers(tripId, tripCount, list, index),
          "tickets": getTckets(tripId, tripCount, list, index)
        });
      }
    }
    // print("***************************************************");
    // print("******************sd******************************");
    // print("******************ds************************");
    // print(mainList);
    // print("************************d********************");
    // print("*******************************df************");

    return mainList;

    // for (int index = 0; index < list.length; index++) {
    //   //List listIdentical =
    //   await getIdenticalBusData(list[index]['tripId']);
    //   // print("-----------------------");
    //   // print(listIdentical);
    //   // print("-----------------------");
    // }
  }

  // getBusFinalData() async {
  //   // Database? db = await instance.database;
  //   List<BusUpload> busUpload = [];
  //   //List firstData = await getBusFirstData();
  //   print('firstData ----- $firstData');
  //   for (int index = 0; index < firstData.length; index++) {
  //     print(firstData[index]['id']);
  //     List secondData = await getBusSecondData(firstData[index]['id']);
  //     List<Tickets>? tickets = [];
  //     print('second data length - ${secondData.length}');
  //     for (int index = 0; index < secondData.length; index++) {
  //       tickets.add(
  //         Tickets(
  //           numberOfMembers: secondData[index]['numberOfMembers'],
  //           ticketId: secondData[index]['ticketId'],
  //         ),
  //       );
  //     }
  //     busUpload.add(BusUpload(
  //       tickets: tickets,
  //       busId: firstData[index]['busId'],
  //       isActive: firstData[index]['isActive'],
  //       startTime: firstData[index]['startTime'],
  //       tripCount: firstData[index]['tripCount'],
  //       endTime: firstData[index]['endTime'],
  //       noOfPassengers: firstData[index]['noOfPassengers'],
  //     ));
  //   }
  //   print(firstData);
  //   return busUpload;
  // }

  // getBusFirstData() async {
  //   Database? db = await instance.database;
  //   return await db!.query('bus_allocation');
  // }

  getBusSecondData(index) async {
    // List<BusUpload> busUpload = [];
    Database? db = await instance.database;
    return await db!.rawQuery(
        'SELECT * FROM allotedTickets_bus WHERE referenceId=${index + 1}');
    // for (int index = 0; index < result.length; index++) {
    //   busUpload.add(BusUpload(tickets: [
    //     result[index]['ticketId'],
    //     result[index]['numberOfMembers']
    //   ]));
    // }
  }

  saveToBusAllocationTable(BusData busAllocated, String ticketId) async {
    Database? db = await instance.database;
    try {
      return await db!.insert('bus_allocation', {
        'tripId': busAllocated.busDetails!.tripId,
        'tripCount': busAllocated.busDetails!.tripCount,
        'ticketId': ticketId,
        'busName': busAllocated.busDetails!.busName,
        'noOfPassengers': busAllocated.busDetails!.noOfPassengers,
        'timestamp': ObjectId().timestamp.toString(),
        'busId': busAllocated.busDetails!.busId,
        'isActive': busAllocated.busDetails!.isActive,
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  getAllocationData() async {
    Database? db = await instance.database;
    try {
      return await db!.query('bus_allocation');
    } on Exception catch (e) {
      print(e);
    }
  }

  updateSeatCount(int? noOfPassengers, String? busId) async {
    Database? db = await instance.database;
    try {
      return await db!.rawUpdate(
          'UPDATE tbl_bus_details SET noOfSeatsDummy = ? WHERE busId= ?',
          [noOfPassengers, busId]);
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTrip(int? noOfPassengers, String? busId, String tripCount) async {
    Database? db = await instance.database;
    var tripId = ObjectId().toString();
    try {
      return await db!.rawUpdate(
          'UPDATE tbl_bus_details SET tripCount = ?, tripId = ?, noOfSeatsDummy = ? WHERE busId= ?',
          [tripCount, tripId, noOfPassengers, busId]);
    } on Exception catch (e) {
      print(e);
    }
  }

  getIdenticalBusData(tripId) async {
    Database? db = await instance.database;
    try {
      List listIdentical = [];
      listIdentical = await db!
          .rawQuery('SELECT * FROM bus_allocation WHERE tripId=?', [tripId]);
      print('the list -- $listIdentical');
    } catch (e) {
      print(e);
    }
  }

  getTckets(tripId, tripCount, List list, int index) {
    List tickets = [];
    for (int indexONe = 0; indexONe < list.length; indexONe++) {
      if (list[index]['tripId'] == tripId &&
          list[index]['tripCount'] == tripCount) {
        tickets.add({
          'ticketId': list[indexONe]['ticketId'],
          'noOfPassengers': list[indexONe]['noOfPassengers']
        });
      }
    }
    return tickets;
  }

  getNoPassengers(tripId, tripCount, List list, int index) {
    var count = 0;

    for (int indexONe = 0; indexONe < list.length; indexONe++) {
      if (list[index]['tripId'] == tripId &&
          list[index]['tripCount'] == tripCount) {
        count = count + int.parse(list[indexONe]['noOfPassengers'].toString());
      }
    }
    return count.toString();
  }

  clearBusTable() async {
    Database? db = await instance.database;
    await db!.delete('bus_allocation');
    await db.delete('tbl_bus_details');
    // await db.delete('allotedTickets_bus');
    // await db!.execute('DELETE FROM bus_allocation');
    // await db.execute('DELETE FROM allotedTickets_bus');
  }

  // updateTrip(int? noOfPassengers, String? busId) async {
  //   Database? db = await instance.database;
  //   var tripId = ObjectId().toString();
  //   try {
  //     return await db!.rawUpdate(
  //         'UPDATE tbl_bus_details SET tripId = ? WHERE busId= ?',
  //         [tripId, busId]);
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }
}

class BusFinalModel {
  String? tripId,
      tripCount,
      ticketId,
      noOfPassengers,
      timestamp,
      busId,
      isActive;
  BusFinalModel({
    this.busId,
    this.isActive,
    this.noOfPassengers,
    this.ticketId,
    this.timestamp,
    this.tripCount,
    this.tripId,
  });
}

class BusUpload {
  String? busId, isActive, tripCount, startTime, endTime, noOfPassengers;
  List<Tickets>? tickets;

  BusUpload(
      {this.busId,
      this.endTime,
      this.isActive,
      this.noOfPassengers,
      this.startTime,
      this.tickets,
      this.tripCount});
}
