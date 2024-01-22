import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/checkinternet/blocinternet.dart';
import 'package:parambikulam/bloc/checkinternet/eventinternet.dart';
import 'package:parambikulam/bloc/checkinternet/stateinternet.dart';
import 'package:parambikulam/config.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/ui/app/auth/loginnew.dart';

class NoInternetPage extends StatefulWidget {
  final String? routeName;
  NoInternetPage({this.routeName});
  _NoInternetPage createState() => _NoInternetPage();
}

class _NoInternetPage extends State<NoInternetPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      body: new SingleChildScrollView(
        child: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bgptrr.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 60.0,
              ),
              new Text(
                "PERIYAR",
                style: StyleElements.heading,
              ),
              new Text(
                "TIGER RESERVE",
                style: StyleElements.subheading,
              ),
              Spacer(),
              noInternet(context),
            ],
          ),
        ),
      ),
    );
  }

  noInternet(context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Internet, \nPlease connect to the internet",
                textAlign: TextAlign.center,
                style: TextStyle(wordSpacing: 2.0, height: 1.2),
              ),
            ],
          ),
          SizedBox(height: 10),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: StyleElements.submitButtonStyle,
                onPressed: () {
                  checkInternet(context);
                },
                child: BlocConsumer<BlocInternet, StateInternet>(
                    builder: (context, state) {
                  if (state is CheckingInternetState) {
                    return SizedBox(
                      height: 18.0,
                      width: 18.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return Icon(
                    Icons.refresh,
                    color: Colors.white,
                  );
                }, listener: (context, state) {
                  if (state is NoInternet) {
                    Fluttertoast.showToast(
                        msg: "Connection failed, please check your connection",
                        toastLength: Toast.LENGTH_LONG);
                    BlocProvider.of<BlocInternet>(context).add(RefreshEvent());
                  }

                  if (state is FoundInternet) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginNew()));
                  }
                }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> checkInternet(BuildContext conext) async {
    BlocProvider.of<BlocInternet>(context).add(CheckingInternet());
    int timeout = 5;
    try {
      http.Response response = await http
          .get(Uri.parse('https://www.parambikulam.org/'))
          .timeout(Duration(seconds: timeout));
      if (response.statusCode == 200) {
        BlocProvider.of<BlocInternet>(context).add(InternetFound());
      }
    } catch (e) {
      BlocProvider.of<BlocInternet>(context).add(NoInternetFound());
    }
  }
}
