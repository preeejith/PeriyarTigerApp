// import 'dart:async';

// import 'package:connectivity/connectivity.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;

// class CheckInternet{
//   Future<bool> getStatus(){

//   }
  
//   final Connectivity _connectivity = new Connectivity();
//    Future<bool> connect() async {
//     ConnectivityResult connectivityResult = ConnectivityResult.none;
//     try {
//       connectivityResult = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       print("Exception occured + " + e.toString());
//     }
//     return _update(connectivityResult);
//   }


//   Future<bool> _update(ConnectivityResult event) async {
//     switch (event) {
//       case ConnectivityResult.none:
       
//         break;
//       case ConnectivityResult.mobile:
       
//         break;
//       case ConnectivityResult.wifi:
//         try {
//           var url = Uri.parse("https://www.google.com/");
//           final response = await http.get(url);
//           if (response.statusCode == 200) {
          
//           } else
//             print("Not Connected");
//         } catch (e) {
        
//         }

//         break;
        
//     }
//     return 
//   }
// }