//originalS

import 'package:flutter/cupertino.dart';
import 'package:parambikulam/ui/assets/local/model/ibmodel.dart';

import 'package:sqflite/sqflite.dart';

ValueNotifier<List<VhaliRecordAddedModel>> IB2dataListNotifier =
    ValueNotifier([]);
late Database ibprogramdb019;

Future<void> initializeIbProgramssDataBase() async {
  ibprogramdb019 = await openDatabase('ibprogramsdb0019.db', version: 1,
      onCreate: (Database ibprogramsdb0019, int version) async {
    ////////////////reservation start/////////////////////////////////
    await ibprogramsdb0019.execute(
        'CREATE TABLE ibprograms6(id INTEGER PRIMARY KEY,started TEXT,isCottage TEXT,status TEXT,_id TEXT,category TEXT,caption TEXT,progName TEXT,description TEXT,startPoint TEXT,endPoint TEXT,duration TEXT,onlinePercent TEXT,minGuest TEXT,maxGuest TEXT,maxAge TEXT,minAge TEXT,reportingTime TEXT,rules TEXT,notes TEXT ,coverImage TEXT,photos TEXT,bookingAvailabilityindian TEXT,bookingAvailabilityforeigner TEXT,bookingAvailabilitychildren TEXT,cottagemaxExtraGuestCount TEXT ,cottagemaxExtraIndianCount TEXT,cottagemaxExtraForeignerCount TEXT,cottagemaxExtraChildrenCount TEXT,activities1 TEXT,activities2 TEXT,activities3 TEXT ,activities4 TEXT)');

    //////new table
    await ibprogramsdb0019.execute(
        'CREATE TABLE ibprogramsslopts(id INTEGER PRIMARY KEY,status TEXT,_id TEXT,startTime TEXT,endTime TEXT,availableNo TEXT,slotisDaywise TEXT,slotstatus TEXT,slot_id TEXT,slotprogramme TEXT,slotfromDate TEXT,slottoDate TEXT,slotslotType TEXT)');
//
    await ibprogramsdb0019.execute(
        'CREATE TABLE getholidays(id INTEGER PRIMARY KEY,hname TEXT,hstatus TEXT,hid TEXT,addedBy TEXT,hstart TEXT,hend TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE reservation(id INTEGER PRIMARY KEY,programid TEXT,slotdetailsid TEXT,bookingdate TEXT,numberofRooms TEXT,guestname TEXT,numberofpersonaccompanying TEXT,guestphone TEXT,reference TEXT,referencephone TEXT,email TEXT,foodpreference TEXT,numberofVehicle TEXT,vehicleNumbers TEXT,details TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE getreservationdata(id INTEGER PRIMARY KEY,reserveno TEXT,bookingDate TEXT,slotid TEXT,slotprogramid TEXT,programName TEXT)');

    ///
    await ibprogramsdb0019.execute(
        'CREATE TABLE reservationonlinedata(id INTEGER PRIMARY KEY,reservedcount TEXT,status TEXT,foodprefered TEXT,vehicleno TEXT,bookingid TEXT,bookingdate TEXT,slotid TEXT,slotprogramid TEXT,programName TEXT,programid TEXT,guestName TEXT,NoofCompaningPerson TEXT,guestPhone TEXT,refered TEXT,referedPhone TEXT,email TEXT,noofVehicles TEXT,details TEXT,edited TEXT,removed TEXT,added TEXT)');
//////////////////////reservation end/////////////////////
//employeeee data
    await ibprogramsdb0019.execute(
        'CREATE TABLE employeelist(id INTEGER PRIMARY KEY,status TEXT,empid TEXT,phonenumber TEXT,role TEXT,userName TEXT,dob TEXT,gender TEXT,assignedUnitId TEXT,assignedTo TEXT,createdate TEXT,updated TEXT,change TEXT,taskAsseigned TEXT,present TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE markattendance(id INTEGER PRIMARY KEY,date TEXT,empId TEXT,isPresent TEXT,leaveType TEXT,reason TEXT,edited TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE datecheck(id INTEGER PRIMARY KEY,date TEXT,keyword TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE datecheck2(id INTEGER PRIMARY KEY,date TEXT,keyword TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE datecheck3(id INTEGER PRIMARY KEY,date TEXT,keyword TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE datecheck4(id INTEGER PRIMARY KEY,date TEXT,keyword TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE attendancedetails(id INTEGER PRIMARY KEY,dateid TEXT,attendanceid TEXT,isPresent TEXT,leaveType TEXT,isSpecialDay TEXT,empId TEXT,phoneNumber TEXT,role TEXT,userName TEXT,dob TEXT,gender TEXT,assignedUnitId TEXT,assignedTo TEXT,attendnaceDate TEXT,description)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE markhalt(id INTEGER PRIMARY KEY,date TEXT,empid TEXT,empname TEXT,empphone TEXT,assignedid TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE haltreport (id INTEGER PRIMARY KEY,dateid TEXT,haltid TEXT,empid TEXT,phoneNumber TEXT,role TEXT,userName TEXT,dob TEXT,gender TEXT,assignedUnitId TEXT,assingedTo TEXT,haltDate TEXT,count TEXT)');
    await ibprogramsdb0019
        .execute('CREATE TABLE profileview(id INTEGER PRIMARY KEY,data TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE countcheck(id INTEGER PRIMARY KEY,assetid TEXT,quantity TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE transferlog(id INTEGER PRIMARY KEY,assetname TEXT,quantity TEXT,unitname TEXT,date TEXT,unitid TEXT,change TEXT,employeename TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE removeassignedemployee(id INTEGER PRIMARY KEY,untiId TEXT,empId TEXT,phoneNumber TEXT)');
////newone
    await ibprogramsdb0019.execute(
        'CREATE TABLE stockupdationquantitycount(id INTEGER PRIMARY KEY,unitid TEXT,assetid TEXT,requestid TEXT,requesttype TEXT,quantity TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE masterviewtable(idno INTEGER PRIMARY KEY,typeOfRequest TEXT,untiId TEXT,unitName TEXT,date TEXT,status TEXT,requestid TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE stockupdation(idno INTEGER PRIMARY KEY,typeOfRequest TEXT,untiId TEXT,unitName TEXT,date TEXT,status TEXT,requestid TEXT,product TEXT,quantity TEXT,assetid TEXT,change TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE newpurchase(idno INTEGER PRIMARY KEY,typeOfRequest TEXT,untiId TEXT,unitName TEXT,date TEXT,status TEXT,requestid TEXT,product TEXT,quantity TEXT,change TEXT,quantity2 TEXT,assetname2 TEXT,remark TEXT,idid TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE repair(idno INTEGER PRIMARY KEY,typeOfRequest TEXT,untiId TEXT,unitName TEXT,date TEXT,status TEXT,requestid TEXT,product TEXT,quantity TEXT,description TEXT,change TEXT,assetid TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE damage(idno INTEGER PRIMARY KEY,typeOfRequest TEXT,untiId TEXT,unitName TEXT,date TEXT,status TEXT,requestid TEXT,product TEXT,quantity TEXT,description TEXT,change TEXT,assetid TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE checkdataonline(idno INTEGER PRIMARY KEY,data TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE productionunitcheckdataonline(idno INTEGER PRIMARY KEY,data TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE productmastertable(idno INTEGER PRIMARY KEY,_id TEXT,productname TEXT,speciality TEXT,description TEXT,unittype TEXT,status TEXT,date TEXT,hasUnit TEXT ,image TEXT,coverimage TEXT,change TEXT,edit TEXT,remove TEXT,added TEXT,unitcount TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE productunit(idno INTEGER PRIMARY KEY,_id TEXT,productid TEXT,unitName TEXT,status TEXT,date TEXT,hassubUnit TEXT )');

    await ibprogramsdb0019.execute(
        'CREATE TABLE productsubunit(idno INTEGER PRIMARY KEY,_id TEXT,productid TEXT,subunitid TEXT,unitName TEXT,date TEXT )');
    await ibprogramsdb0019.execute(
        'CREATE TABLE productimages(idno INTEGER PRIMARY KEY,_id TEXT,productid TEXT,coverimage TEXT,image TEXT )');

    await ibprogramsdb0019.execute(
        'CREATE TABLE productstock(idno INTEGER PRIMARY KEY,_id TEXT,productid TEXT,weight TEXT,totalQuantity TEXT,availableQuantity TEXT,price TEXT,date TEXT )');

    await ibprogramsdb0019.execute(
        'CREATE TABLE attendancecheckupload(id INTEGER PRIMARY KEY,data TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE haltcheckupload(id INTEGER PRIMARY KEY,data TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE productimagesdownload(id INTEGER PRIMARY KEY,productid TEXT,imageurl Text)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE productdelete(id INTEGER PRIMARY KEY,productid TEXT,added TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE productionunitrequestmain(idno INTEGER PRIMARY KEY, id TEXT,requesttype TEXT,status TEXT,count TEXT,date TEXT)');
    await ibprogramsdb0019.execute(
        'CREATE TABLE productionunitrequestsub(idno INTEGER PRIMARY KEY, id TEXT,mainid TEXT,assetname TEXT,quantity TEXT,remark TEXT,requestatus TEXT,transferedQuantity TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE assetswithoutrequest(idno INTEGER PRIMARY KEY, transferedtoId TEXT,assetId TEXT,quantity TEXT,remark TEXT,date TEXT,assetname TEXT,producttype TEXT)');

    await ibprogramsdb0019.execute(
        'CREATE TABLE newrequestnewassets(idno INTEGER PRIMARY KEY, requestId TEXT,assetId TEXT,quantity TEXT,itemId TEXT,date TEXT,assetname TEXT)');
  });
}

///
Future<void> insertnewrequestnewassets(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO newrequestnewassets(requestId,assetId,quantity,itemId,date,assetname) VALUES(?,?,?,?,?,?)',
      [
        value['requestId'],
        value['assetId'],
        value['quantity'],
        value['itemId'],
        value['date'],
        value['assetname'],
      ]);
}

///
///assetswithoutrequest
Future<void> insertassetswithoutrequest(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO assetswithoutrequest(transferedtoId,assetId,quantity,remark,date,assetname,producttype) VALUES(?,?,?,?,?,?,?)',
      [
        value['transferedtoId'],
        value['assetId'],
        value['quantity'],
        value['remark'],
        value['date'],
        value['assetname'],
        value['producttype'],
      ]);
}

//productionunitrequestsub
Future<void> insertproductionunitrequestsub(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productionunitrequestsub(id,mainid,assetname,quantity,remark,requestatus,transferedQuantity) VALUES(?,?,?,?,?,?,?)',
      [
        value['id'],
        value['mainid'],
        value['assetname'],
        value['quantity'],
        value['remark'],
        value['requestatus'],
        value['transferedQuantity'],
      ]);
}

///productionunitrequestmain
Future<void> insertproductionunitrequestmain(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productionunitrequestmain(id,requesttype,status,count,date) VALUES(?,?,?,?,?)',
      [
        value['id'],
        value['requesttype'],
        value['status'],
        value['count'],
        value['date'],
      ]);
}

/////productdelete

Future<void> insertproductdeleteid(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productdelete(productid,added) VALUES(?,?)',
      [value['productid'], value['added']]);
}

//////to input the productimages
Future<void> insertproductimage(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productimagesdownload(productid,imageurl) VALUES(?,?)',
      [value['productid'], value['imageurl']]);
}

///to check the halt uploaded or not
Future<void> uploadhaltcheck(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO haltcheckupload(data) VALUES(?)', [value['data']]);
}

///to check the attendance uploaded or not
Future<void> uploadattendancecheck(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO attendancecheckupload(data) VALUES(?)', [value['data']]);
}
////productmastertable

Future<void> insertproductdetailsonline(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productmastertable(_id,productname,speciality,description,unittype,status,date,hasUnit,image,coverimage,change,edit,remove,added,unitcount) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['_id'],
        value['productname'],
        value['speciality'],
        value['description'],
        value['unittype'],
        value['status'],
        value['date'],
        value['hasUnit'],
        value['image'],
        value['coverimage'],
        value['change'],
        value['edit'],
        value['remove'],
        value['added'],
        value['unitcount'],
      ]);
}
////productunittable

Future<void> insertproductunitonline(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productunit(_id,productid,unitName,status,date,hassubUnit) VALUES(?,?,?,?,?,?)',
      [
        value['_id'],
        value['productid'],
        value['unitName'],
        value['status'],
        value['date'],
        value['hassubUnit'],
      ]);
}

///product subunits

Future<void> insertproductsubunitsonline(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productsubunit(_id,productid,subunitid,unitName,date) VALUES(?,?,?,?,?)',
      [
        value['_id'],
        value['productid'],
        value['subunitid'],
        value['unitName'],
        value['date'],
      ]);
}

//productstock
/////
Future<void> insertproductstocksonline(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO productstock(_id,productid,weight,totalQuantity,availableQuantity,price,date) VALUES(?,?,?,?,?,?,?)',
      [
        value['_id'],
        value['productid'],
        value['weight'],
        value['totalQuantity'],
        value['availableQuantity'],
        value['price'],
        value['date'],
      ]);
}

///productstock,productsubunit,productunit,productmastertable
///check dataonline
Future<void> insertcheckdataonline(Map value) async {
  await ibprogramdb019
      .rawInsert('INSERT INTO checkdataonline(data) VALUES(?)', [
    value['data'],
  ]);
}

//productionunitcheckdataonline
Future<void> insertproductionunitcheckdataonlinedataonline(Map value) async {
  await ibprogramdb019
      .rawInsert('INSERT INTO productionunitcheckdataonline(data) VALUES(?)', [
    value['data'],
  ]);
}
//////for master view table

Future<void> masterviewtableadd(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO masterviewtable(typeOfRequest,untiId,unitName,date,status,requestid) VALUES(?,?,?,?,?,?)',
      [
        value['typeOfRequest'],
        value['untiId'],
        value['unitName'],
        value['date'],
        value['status'],
        value['requestid'],
      ]);
}

///stock updation
///
Future<void> stockupdationviewtable(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO stockupdation(typeOfRequest,untiId,unitName,date,status,requestid,product,quantity,assetid,change) VALUES(?,?,?,?,?,?,?,?,?,?)',
      [
        value['typeOfRequest'],
        value['untiId'],
        value['unitName'],
        value['date'],
        value['status'],
        value['requestid'],
        value['product'],
        value['quantity'],
        value['assetid'],
        value['change'],
      ]);
}

/////new purchase table
///
Future<void> newpurchasetableview(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO newpurchase(typeOfRequest,untiId,unitName,date,status,requestid,product,quantity,change,quantity2,assetname2,remark,idid) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['typeOfRequest'],
        value['untiId'],
        value['unitName'],
        value['date'],
        value['status'],
        value['requestid'],
        value['product'],
        value['quantity'],
        value['change'],
        value['quantity2'],
        value['assetname2'],
        value['remark'],
        value['idid'],
      ]);
}

Future<void> repairview(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO repair(typeOfRequest,untiId,unitName,date,status,requestid,product,quantity,description,change,assetid) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['typeOfRequest'],
        value['untiId'],
        value['unitName'],
        value['date'],
        value['status'],
        value['requestid'],
        value['product'],
        value['quantity'],
        value['description'],
        value['change'],
        value['assetid'],
      ]);
}

Future<void> damageview(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO damage(typeOfRequest,untiId,unitName,date,status,requestid,product,quantity,description,change,assetid) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['typeOfRequest'],
        value['untiId'],
        value['unitName'],
        value['date'],
        value['status'],
        value['requestid'],
        value['product'],
        value['quantity'],
        value['description'],
        value['change'],
        value['assetid'],
      ]);
}

/////stockupdationquantity count
Future<void> stockupdationquantitycount(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO stockupdationquantitycount(unitid,assetid,requestid,requesttype,quantity) VALUES(?,?,?,?,?)',
      [
        value['unitid'],
        value['assetid'],
        value['requestid'],
        value['requesttype'],
        value['quantity'],
      ]);
}

//////removeassignedemployee
///
Future<void> removeassignedemployee(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO removeassignedemployee(untiId,empId,phoneNumber) VALUES(?,?,?)',
      [
        value['untiId'],
        value['empId'],
        value['phoneNumber'],
      ]);
}

///tranfer log
///
Future<void> transferlog(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO transferlog(assetname,quantity,unitname,date,unitid,change,employeename) VALUES(?,?,?,?,?,?,?)',
      [
        value['assetname'],
        value['quantity'],
        value['unitname'],
        value['date'],
        value['unitid'],
        value['change'],
        value['employeename'],
      ]);
}

//////check count quantity
Future<void> countcheck(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO countcheck(assetid,quantity) VALUES(?,?)',
      [value['assetid'], value['quantity']]);
}

/////profile view
Future<void> profileview(Map value) async {
  await ibprogramdb019.rawInsert('INSERT INTO profileview(data) VALUES(?)', [
    value['data'],
  ]);
}

///////employeee list start//////
///
///
///
///
///
///
///
///haltreport
///
Future<void> haltreport(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO haltreport(dateid,haltid,empid,phoneNumber,role,userName,dob,gender,assignedUnitId,assingedTo,haltDate,count) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['dateid'],
        value['haltid'],
        value['empid'],
        value['phoneNumber'],
        value['role'],
        value['userName'],
        value['dob'],
        value['gender'],
        value['assignedUnitId'],
        value['assingedTo'],
        value['haltDate'],
        value['count'],
      ]);
}

////mark halt
Future<void> markhalt(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO markhalt(date,empid,empname,empphone,assignedid) VALUES(?,?,?,?,?)',
      [
        value['date'],
        value['empid'],
        value['empname'],
        value['empphone'],
        value['assignedid'],
      ]);
}

//////atendtance details
Future<void> attendanceDetails(Map value) async {
  await ibprogramdb019.rawInsert(
    'INSERT INTO attendancedetails(dateid,attendanceid,isPresent,leaveType,isSpecialDay,empId,phoneNumber,role,userName,dob,gender,assignedUnitId,assignedTo,attendnaceDate,description) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
    [
      value['dateid'],
      value['attendanceid'],
      value['isPresent'],
      value['leaveType'],
      value['isSpecialDay'],
      value['empId'],
      value['phoneNumber'],
      value['role'],
      value['userName'],
      value['dob'],
      value['gender'],
      value['assignedUnitId'],
      value['assignedTo'],
      value['attendnaceDate'],
      value['description'],
    ],
  );
}

Future<void> datecheck(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO datecheck(date,keyword) VALUES(?,?)',
      [value['date'], value['keyword']]);
}

Future<void> datecheck2(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO datecheck2(date,keyword) VALUES(?,?)',
      [value['date'], value['keyword']]);
}

Future<void> datecheck3(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO datecheck3(date,keyword) VALUES(?,?)',
      [value['date'], value['keyword']]);
}

Future<void> a(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO datecheck4(date,keyword) VALUES(?,?)',
      [value['date'], value['keyword']]);
}

Future<void> markAttendance(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO markattendance(date,empId,isPresent,leaveType,reason,edited) VALUES(?,?,?,?,?,?)',
      [
        value['date'],
        value['empId'],
        value['isPresent'],
        value['leaveType'],
        value['reason'],
        value['edited'],
      ]);
}

//////// zz
Future<void> getemployeelist(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO employeelist(status,empid,phonenumber,role,userName,dob,gender,assignedUnitId,assignedTo,createdate,updated,change,taskAsseigned,present) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['status'],
        value['empid'],
        value['phonenumber'],
        value['role'],
        value['userName'],
        value['dob'],
        value['gender'],
        value['assignedUnitId'],
        value['assignedTo'],
        value['createdate'],
        value['updated'],
        value['change'],
        value['taskAsseigned'],
        value['present'],
      ]);
}

/////////////reservation start//////////////////////////////
/////for getting the reservationdata
///
///
///
///

Future<void> getonlineresevationdata(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO reservationonlinedata(reservedcount,status,foodprefered,vehicleno,bookingid,bookingdate,slotid,slotprogramid,programName,programid,guestName,NoofCompaningPerson,guestPhone,refered,referedPhone,email,noofVehicles,details,edited,removed,added) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['reservedcount'],
        value['status'],
        value['foodprefered'],
        value['vehicleno'],
        value['bookingid'],
        value['bookingdate'],
        value['slotid'],
        value['slotprogramid'],
        value['programName'],
        value['programid'],
        value['guestName'],
        value['NoofCompaningPerson'],
        value['guestPhone'],
        value['refered'],
        value['referedPhone'],
        value['email'],
        value['noofVehicles'],
        value['details'],
        value['edited'],
        value['removed'],
        value['added'],
      ]);
}

///needed
Future<void> getinsertreservationdata(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO getreservationdata(reserveno,bookingDate,slotid,slotprogramid,programName) VALUES(?,?,?,?,?)',
      [
        value['reserveno'],
        value['bookingDate'],
        value['slotid'],
        value['slotprogramid'],
        value['programName'],
      ]);
}

////to remove the row
Future<void> deleteinsertreservationdata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM getreservationdata WHERE id = ?', [index]);
}

/////
///
Future<void> deleteinsertproductdeletedata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM productdelete WHERE id = ?', [index]);
}

////to update the above table
/////
//employeelist
Future<void> getupdatereservationdata(reserveno, date, programid) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE getreservationdata SET reserveno = ? WHERE bookingDate= ? and slotprogramid=?',
      [reserveno.toString(), date, programid]);
}

//////update the matser product table
//productmastertable
Future<void> getupdateproductmastertabledata(
    productname, productdescription, productspeciality, change, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productmastertable SET productname = ? ,description = ?,speciality=?,change=? WHERE idno= ? ',
      [
        productname.toString(),
        productdescription,
        productspeciality,
        change,
        id
      ]);
}

///for chnage the chnage status in master table
Future<void> getchangestatusproductmastertabledata(change, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productmastertable SET change=? WHERE idno= ? ', [change, id]);
}

//////chnages the remove true status
Future<void> getupdatechangestatusmastertabledata(removestatus, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productmastertable SET remove=? WHERE idno= ? ',
      [removestatus, id]);
}

///for change the price of main stock
///
Future<void> getupdateproductstockdata(price, totalQuantity, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productstock SET price = ? ,totalQuantity = ? WHERE idno= ? ',
      [price.toString(), totalQuantity, id]);
}

//////to chnage the name of units
Future<void> getupdateproductunitdata(unitName, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productunit SET unitName = ?  WHERE idno= ? ',
      [unitName.toString(), id]);
}

///for chnage the quantity and weith of unit without the sun=bunit
Future<void> getupdateproductstockunitdata(price, totalQuantity, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productstock SET price = ? ,totalQuantity = ? WHERE idno= ? ',
      [price.toString(), totalQuantity, id]);
}

///update data of subunitdata
///
Future<void> getupdateproductsubunitdata(unitName, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productsubunit SET unitName = ?  WHERE idno= ? ',
      [unitName.toString(), id]);
}

///for update the stock in the subunitdata
Future<void> getupdateproductstocksubunitdata(price, totalQuantity, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE productstock SET price = ? ,totalQuantity = ? WHERE idno= ? ',
      [price.toString(), totalQuantity, id]);
}

////update the attendnace
///
Future<void> getmarkattendancedata(
    isPresent, leaveType, reason, edited, empId) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE markattendance SET isPresent = ? ,leaveType=?,reason=?,edited=? WHERE empId= ?  ',
      [isPresent.toString(), leaveType, reason, edited, empId]);
}

///for update the attendnace details online
///
Future<void> getattendancedetailsdata(
    isPresent, leaveType, description, empId) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE attendancedetails SET isPresent = ? ,leaveType=? ,description =?WHERE empId= ?  ',
      [isPresent.toString(), leaveType, description, empId]);
}

////stockupdation

Future<void> getupdatestockupdationdata(status, change, idno) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE stockupdation SET status = ?,change=? WHERE idno= ? ',
      [status.toString(), change, idno]);
}

///
////master table
Future<void> getupdatemastertabledata(status, idno) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE masterviewtable SET status = ? WHERE idno= ? ',
      [status.toString(), idno]);
}

Future<void> getupdatenewpurchasedata(status, change, quantity2, idno) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE newpurchase SET status = ?,change=? ,quantity2=? WHERE idno= ? ',
      [status.toString(), change, quantity2, idno]);
}

////for updation in damage
Future<void> getupdatedamagedata(status, change, idno) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE damage SET status = ?,change=? WHERE idno= ? ',
      [status.toString(), change, idno]);
}

///for updation in repair
///
Future<void> getupdaterepairdata(status, change, idno) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE repair SET status = ?,change=? WHERE idno= ? ',
      [status.toString(), change, idno]);
}

/////upddate the employee list
/////employeelist
Future<void> getupdateemployeelistdata(
    assignedUnitId, assignedTo, empid) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE employeelist SET assignedUnitId = ?,assignedTo=? WHERE empid= ? ',
      [assignedUnitId.toString(), assignedTo, empid]);
}

Future<void> getupdateemployeedutyassigndata(taskAsseigned, empid) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE employeelist SET taskAsseigned = ? WHERE empid= ? ',
      [taskAsseigned.toString(), empid]);
}

Future<void> getupdatepresentdata(present, empid) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE employeelist SET present = ? WHERE empid= ? ',
      [present.toString(), empid]);
}
//  value['status'],
//     value['empid'],
//     value['phonenumber'],
//     value['role'],
//     value['userName'],
//     value['dob'],
//     value['gender'],
//     value['assignedUnitId'],
//     value['assignedTo'],
//     value['createdate'],
//     value['updated'],
//     value['change']

////reservation

Future<void> insertreservationdata(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO reservation(programid,slotdetailsid,bookingdate,numberofRooms,guestname,numberofpersonaccompanying,guestphone,reference,referencephone,email,foodpreference,numberofVehicle,vehicleNumbers,details) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['programid'],
        value['slotdetailsid'],
        value['bookingdate'],
        value['numberofRooms'],
        value['guestname'],
        value['numberofpersonaccompanying'],
        value['guestphone'],
        value['reference'],
        value['referencephone'],
        value['email'],
        value['foodpreference'],
        value['numberofVehicle'],
        value['vehicleNumbers'],
        value['details'],
      ]);
}

///getholidays insertion

Future<void> insertHolidaysdata(Map value) async {
  await ibprogramdb019.rawInsert(
      'INSERT INTO getholidays(hname,hstatus,hid,addedBy,hstart,hend) VALUES(?,?,?,?,?,?)',
      [
        value['hname'],
        value['hstatus'],
        value['hid'],
        value['addedBy'],
        value['hstart'],
        value['hend']
      ]);
}

//new inserrtion
Future<void> slotIBprogramsdata(Map value) async {
  // await ibprogramdb019.delete("ibprogramsslopts");
  ///ibprogramsslopts
  ///ibprograms6
  await ibprogramdb019.rawInsert(
      'INSERT INTO ibprogramsslopts(status,_id,startTime,endTime,availableNo,slotisDaywise,slotstatus,slot_id,slotprogramme,slotfromDate,slottoDate,slotslotType) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['status'],
        value['_id'],
        value['startTime'],
        value['endTime'],
        value['availableNo'],
        value['slotisDaywise'],
        value['slotstatus'],
        value['slot_id'],
        value['slotprogramme'],
        value['slotfromDate'],
        value['slottoDate'],
        value['slotslotType'],
      ]);
}

Future<void> addIBprogramsdata(Map value) async {
  // await ibprogramdb019.delete("ibprograms6");
  await ibprogramdb019.rawInsert(
      'INSERT INTO ibprograms6(started,isCottage,status,_id,category,caption,progName,description,startPoint,endPoint,duration,onlinePercent,minGuest,maxGuest,maxAge,minAge,reportingTime,rules,notes,coverImage,photos,bookingAvailabilityindian,bookingAvailabilityforeigner,bookingAvailabilitychildren,cottagemaxExtraGuestCount,cottagemaxExtraIndianCount,cottagemaxExtraForeignerCount,cottagemaxExtraChildrenCount,activities1,activities2,activities3,activities4) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
      [
        value['started'],
        value['isCottage'],
        value['status'],
        value['_id'],
        value['category'],
        value['caption'],
        value['progName'],
        value['description'],
        value['startPoint'],
        value['endPoint'],
        value['duration'],
        value['onlinePercent'],
        value['minGuest'],
        value['maxGuest'],
        value['maxAge'],
        value['minAge'],
        value['reportingTime'],
        value['rules'],
        value['notes'],
        value['coverImage'],
        value['photos'],
        value['bookingAvailabilityindian'],
        value['bookingAvailabilityforeigner'],
        value['bookingAvailabilitychildren'],
        value['cottagemaxExtraGuestCount'],
        value['cottagemaxExtraIndianCount'],
        value['cottagemaxExtraForeignerCount'],
        value['cottagemaxExtraChildrenCount'],
        value['activities1'],
        value['activities2'],
        value['activities3'],
        value['activities4'],
      ]);
}

////////////////////////////////////////////////////////////////reservation end////////////
Future<void> deletealldata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM ibprograms6 WHERE id = ?', [index]);
}

Future<void> deletealldataslot(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM ibprogramsslopts WHERE id = ?', [index]);
}

Future<void> deleteallholidays(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM getholidays WHERE id = ?', [index]);
}

Future<void> deletereservationdata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM reservation WHERE id = ?', [index]);
}

Future<void> deletegetreservationdata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM getreservationdata WHERE id = ?', [index]);
}

//onlinereservationdatadelete
Future<void> deleteonlinereservationalllistdata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM reservationonlinedata WHERE id = ?', [index]);
}

///employee delete
Future<void> deleteemployeelist(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM employeelist WHERE id = ?', [index]);
}

//////
Future<void> deleteproductmastertable(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM productmastertable WHERE idno = ?', [index]);
}

///to delete the marked attentdance
Future<void> deletemarkedattendence(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM markattendance WHERE id = ?', [index]);
}

////delete the date checktable
///
Future<void> deletedatechecktable(index) async {
  await ibprogramdb019.rawDelete('DELETE FROM datecheck WHERE id = ?', [index]);
}

Future<void> deletedatechecktable2(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM datecheck2 WHERE id = ?', [index]);
}

Future<void> deletedatechecktable3(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM datecheck3 WHERE id = ?', [index]);
}

Future<void> deletedatechecktable4(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM datecheck4 WHERE id = ?', [index]);
}

Future<void> deleteattendancedetails(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM attendancedetails WHERE id = ?', [index]);
}
//////for gettinh the list
///

///delete halt report
///
///
Future<void> deletehaltreportdetails(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM haltreport WHERE id = ?', [index]);
}

///delete quantitycount
Future<void> deletequantitycount(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM countcheck WHERE id = ?', [index]);
}

////stockupdationquantitycount
///stockupdationquantitycount
Future<void> deletestockquantitycount(index) async {
  await ibprogramdb019.rawDelete(
      'DELETE FROM stockupdationquantitycount WHERE id = ?', [index]);
}

//delete transferlog

Future<void> deletetranferlog(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM transferlog WHERE id = ?', [index]);
}

///assetswithoutrequest,assetswithoutrequest
Future<void> deleteassetswithoutrequest(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM assetswithoutrequest WHERE idno = ?', [index]);
}

///newrequestnewassets
Future<void> deletenewrequestnewassets(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM newrequestnewassets WHERE idno = ?', [index]);
}

Future<void> deletefulltranferlog() async {
  await ibprogramdb019.delete("transferlog");
}

///haltcheckupload
Future<void> deletefullhaltcheckupload() async {
  await ibprogramdb019.delete("haltcheckupload");
}

//////ibprogramsslopts
Future<void> deletefullibprogramssloptsupload() async {
  await ibprogramdb019.delete("haltcheckupload");
}

///ibprograms6
Future<void> deleteibprograms6upload() async {
  await ibprogramdb019.delete("ibprograms6");
}

///productimages
///
Future<void> deletefullproductimages() async {
  await ibprogramdb019.delete("productimagesdownload");
}

///productdelete
Future<void> deletefullproductdelete() async {
  await ibprogramdb019.delete("productdelete");
}

//productionunitrequestmain
Future<void> deletefullproductionunitrequestmain() async {
  await ibprogramdb019.delete("productionunitrequestmain");
}

///productionunitrequestsub
Future<void> deletefullproductionunitrequestsub() async {
  await ibprogramdb019.delete("productionunitrequestsub");
}

////assetswithoutrequest
Future<void> deletefullassetswithoutrequest() async {
  await ibprogramdb019.delete("assetswithoutrequest");
}

////newrequestnewassets
Future<void> deletefullnewrequestnewassets() async {
  await ibprogramdb019.delete("newrequestnewassets");
}

///attendancecheckupload
///
Future<void> deletefullattendancecheckupload() async {
  await ibprogramdb019.delete("attendancecheckupload");
}

///productstock
Future<void> deletefullproductstock() async {
  await ibprogramdb019.delete("productstock");
}

////productsubunit
///
Future<void> deletefullproductsubunit() async {
  await ibprogramdb019.delete("productsubunit");
}

///productunit
Future<void> deletefullproductunit() async {
  await ibprogramdb019.delete("productunit");
}

///productmastertable
//
Future<void> deletefullproductmastertable() async {
  await ibprogramdb019.delete("productmastertable");
}

//
///////////////////////////////////////////////
///delete masterviewtable
///
Future<void> deletemasterviewtable() async {
  await ibprogramdb019.delete("masterviewtable");
}

//delete stockupdation
Future<void> deletestockupdations() async {
  await ibprogramdb019.delete("stockupdation");
}

///newpurchase
///
Future<void> deletenewpurchase() async {
  await ibprogramdb019.delete("newpurchase");
}

Future<void> deletedamage() async {
  await ibprogramdb019.delete("damage");
}

Future<void> deleterepair() async {
  await ibprogramdb019.delete("repair");
}

///delete the removeassetedemployee
//removeassignedemployee

Future<void> deleteremoveassignedemployee(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM removeassignedemployee WHERE id = ?', [index]);
}

//delte halt
Future<void> deletehaltdetails(index) async {
  await ibprogramdb019.rawDelete('DELETE FROM markhalt WHERE id = ?', [index]);
}

///for updating the table
Future<void> updateslotdata(index, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE ibprogramsslopts SET availableNo = ? WHERE _id= ?',
      [index.toString(), id]);
}

//transferlog
getAlltransferlogdata() async {
  List items35 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('transferlog');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items35.add(map);
  }
  return items35;
}

///stockupdationquantity count
// stockupdationquantitycount

getAllstockquantitycountdata() async {
  List items41 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('stockupdationquantitycount');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items41.add(map);
  }
  return items41;
}

////////
///masterviewtable
getAllmasterviewtabledata() async {
  List items42 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('masterviewtable');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items42.add(map);
  }
  return items42;
}

///checkdataonline
///
getcheckdataonlinetabledata() async {
  List items48 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('checkdataonline');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items48.add(map);
  }
  return items48;
}

////
///productionunitcheckdataonline
getproductionunitcheckdataonlinedata() async {
  List items66 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productionunitcheckdataonline');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items66.add(map);
  }
  return items66;
}

//////////productstock,productsubunit,productunit,productmastertable

///productmastertable
getproductmastertabletabledata() async {
  List items51 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productmastertable');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items51.add(map);
  }
  return items51;
}

///productunit
getproductunittabledata() async {
  List items52 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productunit');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items52.add(map);
  }
  return items52;
}

///productsubunit
getproductsubunittabledata() async {
  List items53 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productsubunit');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items53.add(map);
  }
  return items53;
}

///productstock
getproductstocktabledata() async {
  List items54 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productstock');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items54.add(map);
  }
  return items54;
}

//attendancecheckupload
///
///
///
getattendancecheckuploaddata() async {
  List items56 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('attendancecheckupload');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items56.add(map);
  }
  return items56;
}

/////haltcheckupload
///
gethaltcheckuploaddata() async {
  List items57 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('haltcheckupload');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items57.add(map);
  }
  return items57;
}

///productimages
getproductimagesdata() async {
  List items58 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productimagesdownload');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items58.add(map);
  }
  return items58;
}

//productdelete
getproductdeletedata() async {
  List items59 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productdelete');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items59.add(map);
  }
  return items59;
}

//productionunitrequestmain
getproductionunitrequestmaindata() async {
  List items60 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productionunitrequestmain');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items60.add(map);
  }
  return items60;
}

///productionunitrequestsub
getproductionunitrequestsubdata() async {
  List items61 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('productionunitrequestsub');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items61.add(map);
  }
  return items61;
}

///assetswithoutrequest
getassetswithoutrequestdata() async {
  List items62 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('assetswithoutrequest');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items62.add(map);
  }
  return items62;
}

//newrequestnewassets
getnewrequestnewassetsdata() async {
  List items63 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('newrequestnewassets');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items63.add(map);
  }
  return items63;
}

//stockupdation
getAllstockupdationdata() async {
  List items43 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('stockupdation');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items43.add(map);
  }
  return items43;
}

///new pur hase
getAllnewpurchasedata() async {
  List items44 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('newpurchase');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items44.add(map);
  }
  return items44;
}

///repair
getAllrepairdata() async {
  List items45 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('repair');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items45.add(map);
  }
  return items45;
}
//damage

getAlldamagedata() async {
  List items46 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('damage');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items46.add(map);
  }
  return items46;
}

///removeassigedemployee
///
//removeassignedemployee
getAllremoveassignedemployeedata() async {
  List items39 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('removeassignedemployee');

  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items39.add(map);
  }
  return items39;
}

///check the count
getAlltransfercountdata() async {
  List items34 = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('countcheck');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items34.add(map);
  }
  return items34;
}

getAllIbProgramdata() async {
  List items = [];
  IB2dataListNotifier.value.clear();

  final _values = await ibprogramdb019.query('ibprograms6');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values) {
    items.add(map);
  }
  return items;
}

getAllIbHolidaysdata() async {
  List items3 = [];
  IB2dataListNotifier.value.clear();

  final _values3 = await ibprogramdb019.query('getholidays');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values3) {
    items3.add(map);
  }
  return items3;
}
////to check count
///

/////////////special work
///
///
/// await ibprogramdb019.rawUpdate(
// 'UPDATE ibprogramsslopts SET availableNo = ? WHERE _id= ?',
// [index.toString(), id]);
getAllReservationSortedDate(date1, date2) async {
  List items17 = [];
  IB2dataListNotifier.value.clear();
  final _values17 = await ibprogramdb019.rawQuery(
      "SELECT * FROM reservationonlinedata WHERE bookingdate >= ? AND bookingdate <= ?",
      [date1, date2]);
  print(_values17);
  print(_values17.length);
  // print(_values17[0]['bookingdate']);
  if (_values17.length == 0) {
    items17 = [];
  }

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values17) {
    items17.add(map);
  }
  return items17;
}

//demo

// getAllReservationSortedDate(date1, date2) async {
//   List items17 = [];
//   IB2dataListNotifier.value.clear();
//   final _values17 = await ibprogramdb019.rawQuery(
//       "SELECT * FROM reservationonlinedata WHERE bookingdate >= '2022-05-12T18:30:00.000Z' AND bookingdate <= '2022-05-25T00:00:00.000Z'");
//   print(_values17);
//   print(_values17.length);
//   print(_values17[0]['bookingdate']);

//   // print(_values);
//   IB2dataListNotifier.value.clear();

//   for (var map in _values17) {
//     items17.add(map);
//   }
//   return items17;
// }

////////
////for employee list
getAllEmployeeListdata() async {
  List items6 = [];
  IB2dataListNotifier.value.clear();

  final _values6 = await ibprogramdb019.query('employeelist');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values6) {
    items6.add(map);
  }
  return items6;
}

/////to get the date check
///
///
///
///
///

// Future<void> deleteattendancedetails(index) async {
//   await ibprogramdb019
//       .rawDelete('DELETE FROM attendancedetails WHERE id = ?', [index]);
// }

// slotteddatelist(dateOne,dateTwo

// ) async {
//   List items10 = [];
//   IB2dataListNotifier.value.clear();

//   final _values10 = await ibprogramdb019.query('datecheck');

//   // print(_values);
//   IB2dataListNotifier.value.clear();

//   for (var map in _values10) {
//     items10.add(map);
//   }
//   return items10;
// }

getAllDatedata() async {
  List items10 = [];
  IB2dataListNotifier.value.clear();

  final _values10 = await ibprogramdb019.query('datecheck');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values10) {
    items10.add(map);
  }
  return items10;
}

getAllDatedata2() async {
  List items11 = [];
  IB2dataListNotifier.value.clear();

  final _values11 = await ibprogramdb019.query('datecheck2');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values11) {
    items11.add(map);
  }
  return items11;
}

getAllDatedata3() async {
  List items14 = [];
  IB2dataListNotifier.value.clear();

  final _values14 = await ibprogramdb019.query('datecheck3');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values14) {
    items14.add(map);
  }
  return items14;
}

getAllDatedata4() async {
  List items15 = [];
  IB2dataListNotifier.value.clear();

  final _values14 = await ibprogramdb019.query('datecheck4');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values14) {
    items15.add(map);
  }
  return items15;
}

///halt report
getAllHaltReport() async {
  List items16 = [];
  IB2dataListNotifier.value.clear();

  final _values16 = await ibprogramdb019.query('haltreport');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values16) {
    items16.add(map);
  }
  return items16;
}

/////attendance deatils
///
getAllAttendanceDetailsdata() async {
  List items12 = [];
  IB2dataListNotifier.value.clear();

  final _values12 = await ibprogramdb019.query('attendancedetails');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values12) {
    items12.add(map);
  }
  return items12;
}

////toget the halt details
getAllHaltDetailsdata() async {
  List items13 = [];
  IB2dataListNotifier.value.clear();

  final _values13 = await ibprogramdb019.query('markhalt');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values13) {
    items13.add(map);
  }
  return items13;
}

/////online reservation list
getReservationListOnlinedata() async {
  List items7 = [];
  IB2dataListNotifier.value.clear();

  final _values7 = await ibprogramdb019.query('reservationonlinedata');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values7) {
    items7.add(map);
  }
  return items7;
}

///for delete complete list of it
///
getdeleteReservationListOnlinedata() async {
  try {
    await ibprogramdb019.delete("reservationonlinedata");
  } catch (e) {
    print(e);
  }
}

///////////
///
////for removing the
Future<void> deletereservationonlinedata(index) async {
  await ibprogramdb019
      .rawDelete('DELETE FROM reservationonlinedata WHERE id = ?', [index]);
}

////update for removes
Future<void> updateremovereservationonlinedata(removed, id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE reservationonlinedata SET removed=? WHERE id= ?', [removed, id]);
}

////////update the reservation list
Future<void> updatereservationonlinedata(
    foodprefered,
    vehicleno,
    guestName,
    noofCompaningPerson,
    guestPhone,
    refered,
    referedPhone,
    email,
    noofVehicles,
    details,
    edited,
    removed,
    id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE reservationonlinedata SET foodprefered = ?,vehicleno=?,guestName=?,NoofCompaningPerson=?,guestPhone=?,refered=?,referedPhone=?,email=?,noofVehicles=?,details=?,edited=?,removed=? WHERE id= ?',
      [
        foodprefered,
        vehicleno,
        guestName,
        noofCompaningPerson,
        guestPhone,
        refered,
        referedPhone,
        email,
        noofVehicles,
        details,
        edited,
        removed,
        id
      ]);
}

/////new one
getAllIbgetReservationlist() async {
  List items5 = [];
  IB2dataListNotifier.value.clear();

  final _values5 = await ibprogramdb019.query('getreservationdata');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values5) {
    items5.add(map);
  }
  return items5;
}

///for delete complete list of it
getdeleteIbgetReservationlist() async {
  try {
    await ibprogramdb019.delete("getreservationdata");
  } catch (e) {
    print(e);
  }
}

getAllReservationdata() async {
  List items4 = [];
  IB2dataListNotifier.value.clear();

  final _values4 = await ibprogramdb019.query('reservation');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values4) {
    items4.add(map);
  }
  return items4;
}
/////updated the reservation detaile
///

Future<void> updatereservationdata(
    foodprefered,
    vehicleno,
    guestName,
    noofCompaningPerson,
    guestPhone,
    refered,
    referedPhone,
    email,
    noofVehicles,
    details,
    id) async {
  await ibprogramdb019.rawUpdate(
      'UPDATE reservation SET foodpreference = ?,vehicleNumbers=?,guestname=?,numberofpersonaccompanying=?,guestphone=?,reference=?,referencephone=?,email=?,numberofVehicle=?,details=? WHERE id= ?',
      [
        foodprefered,
        vehicleno,
        guestName,
        noofCompaningPerson,
        guestPhone,
        refered,
        referedPhone,
        email,
        noofVehicles,
        details,
        id
      ]);
}

///to get all marked attendance
getAllMarkedAttendancedata() async {
  List items9 = [];
  IB2dataListNotifier.value.clear();

  final _values9 = await ibprogramdb019.query('markattendance');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values9) {
    items9.add(map);
  }
  return items9;
}

////
getAllIbProgramslotdata() async {
  List items2 = [];
  IB2dataListNotifier.value.clear();

  final _values2 = await ibprogramdb019.query('ibprogramsslopts');

  // print(_values);
  IB2dataListNotifier.value.clear();

  for (var map in _values2) {
    items2.add(map);
  }
  return items2;
}

Future<void> deleteStudent(int d) async {
  getAllIbProgramdata();
}
/////
