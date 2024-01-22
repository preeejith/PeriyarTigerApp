import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/authbloc/employeelogin_bloc.dart';
import 'package:parambikulam/bloc/assets/authbloc/employeelogin_event.dart';
import 'package:parambikulam/bloc/assets/authbloc/employeelogin_state.dart';
import 'package:parambikulam/bloc/checkinternet/blocinternet.dart';
import 'package:parambikulam/bloc/checkinternet/eventinternet.dart';
import 'package:parambikulam/bloc/checkinternet/stateinternet.dart';

import 'package:parambikulam/config.dart';
import 'package:parambikulam/ui/app/auth/nointernet.dart';
import 'package:http/http.dart' as http;
import 'package:parambikulam/ui/app/entrypoint/entrybookinghome.dart';
import 'package:parambikulam/ui/app/reception_aju/homepage.dart';
import 'package:parambikulam/ui/assets/bottombarunits.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/bottomnavechoshop.dart';

class LoginNew extends StatefulWidget {
  _NewLoginPage createState() => _NewLoginPage();
}

class _NewLoginPage extends State<LoginNew> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneNumberController = TextEditingController();
  bool _obscureText = true;
  bool isStarted = false;

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  void dispose() {
    BlocInternet().close();
    super.dispose();
  }

  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // phoneNumberController.text = "kareem@gmail.com";
    // passwordController.text = "12345678";
    return BlocConsumer<BlocInternet, StateInternet>(builder: (context, state) {
      if (state is FoundInternet) {
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
                    "P E R I Y A R",
                    style: StyleElements.heading,
                  ),
                  new Text(
                    "TIGER RESERVE",
                    style: StyleElements.subheading,
                  ),
                  Spacer(),
                  _formData(),
                ],
              ),
            ),
          ),
        );
      }

      return Center(
        child: SizedBox(
          height: 28.0,
          width: 28.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is NoInternet) {
        // return NoInternetPage();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NoInternetPage()));
        // return CircularProgressIndicator();
      }
    });
  }

  _formData() {
    return new Form(
      autovalidateMode: AutovalidateMode.disabled,
      key: _formKey,
      child: new Card(
        margin: EdgeInsets.zero,
        elevation: 20.0,
        color: Colors.transparent,
        child: new Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                "Please Login to Continue",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              new SizedBox(
                height: 10.0,
              ),
              new Text("Username"),
              SizedBox(
                height: 10,
              ),
              new TextFormField(
                style: new TextStyle(color: Colors.black),
                controller: phoneNumberController,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Enter Mobile Number/Email";
                  }
                  return null;
                },
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                autofocus: true,
                decoration: new InputDecoration(
                  errorStyle: new TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  labelText: "Mobile Number/Email",
                  labelStyle:
                      new TextStyle(fontSize: 14.0, color: Colors.black),
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10,
              ),
              new Text(
                "Password",
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              new TextFormField(
                autofocus: true,
                obscureText: _obscureText,
                style: new TextStyle(color: Colors.black),
                controller: passwordController,
                validator: (value) {
                  if (value == "" || value == null) {
                    return "Enter Password";
                  }
                  return null;
                },
                cursorColor: Colors.black,
                keyboardType: TextInputType.visiblePassword,
                decoration: new InputDecoration(
                  errorStyle: new TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  labelText: "Password",
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText == false
                            ? _obscureText = true
                            : _obscureText = false;
                      });
                    },
                    child: Icon(
                      _obscureText == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                  labelStyle:
                      new TextStyle(fontSize: 14.0, color: Colors.black),
                  filled: true,
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 5.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        Fluttertoast.showToast(msg: "Will work soon.");
                      },
                      child: Text("Forgot Password ?")),
                ],
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: new TextButton(
                  style: StyleElements.submitButtonStyle,
                  onPressed: () async {
                    BlocProvider.of<GetEmployeeloginBloc>(context)
                        .add(Employeeloginentry(
                      phonenumber: phoneNumberController.text.trim(),
                      password: passwordController.text.trim(),
                    ));
                    ////
                    // if (_formKey.currentState!.validate()) {
                    //   bool connection = await checkInternet();
                    //   if (connection == true) {
                    //     isStarted = true;

                    //     /////newly added bloc
                    //     BlocProvider.of<GetEmployeeloginBloc>(context)
                    //         .add(Employeeloginentry(
                    //       phonenumber: phoneNumberController.text.trim(),
                    //       password: passwordController.text.trim(),
                    //     ));

                    //     //////assetchanged
                    //     // BlocProvider.of<LoginBloc>(context).add(GetOTP(
                    //     //   number: phoneNumberController.text.trim(),
                    //     //   password: passwordController.text.trim(),
                    //     // ));
                    //   }
                    //   print("clicked");

                    //   // Alert.alert(context, "title", "body");
                    // }
                  },

                  ///////assets chnged
                  // child: new BlocConsumer<LoginBloc, LoginState>(
                  //     builder: (context, state) {
                  //       if (state is OtpInitialize) {
                  //         return SizedBox(
                  //           height: 28.0,
                  //           width: 28.0,
                  //           child: CircularProgressIndicator(
                  //             valueColor:
                  //                 AlwaysStoppedAnimation<Color>(Colors.white),
                  //             strokeWidth: 2,
                  //           ),
                  //         );
                  //       } else if (state is LoginError) {
                  //         isStarted == true
                  //             ? _showToast("Incorrect Email/Password")
                  //             : SizedBox.shrink();
                  //         return new Text("Signin",
                  //             style: StyleElements.buttonTextStyleBold);
                  //       } else if (state is LoginSuccess) {
                  //         SchedulerBinding.instance!.addPostFrameCallback((_) {
                  //           Navigator.pushReplacementNamed(context, '/home');
                  //         });
                  //       }
                  //       return new Text("Signin",
                  //           style: StyleElements.buttonTextStyleBold);
                  //     },
                  //     listener: (context, state) {}),
///////assets chnged
                  child: BlocConsumer<GetEmployeeloginBloc, EmployeeloginState>(
                      builder: (context, state) {
                    if (state is Employeelogin) {
                      return const SizedBox(
                        height: 18.0,
                        width: 18.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                          strokeWidth: 2,
                        ),
                      );
                    } else {
                      return new Text("Signin",
                          style: StyleElements.buttonTextStyleBold);
                    }
                  }, listener: (context, state) {
                    if (state is Employeeloginsuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CustomerBottomNavigation()));
                    } else if (state is ProductionUnitsuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UnitsAssetsBottomNavigation()));
                    } else if (state is IBsuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UnitsAssetsBottomNavigation()));
                    } else if (state is Ecoshopsuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EchoShopBottomNavigation()));
                    } else if (state is Stayssuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UnitsAssetsBottomNavigation()));
                    } else if (state is EmployeeloginError) {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.white,
                          msg: state.error,
                          textColor: Colors.black);
                    } else if (state is CheckPostSuccess) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EntryHomePage()));
                    } else if (state is ReceptionSuccess) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }

                    //  else {/
                    //   Navigator.pushReplacement(context,
                    //       MaterialPageRoute(builder: (context) => HomePage()));
                    // }
                  }),
                ),
              ),
              SizedBox(height: 20.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "version 1.0.0",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showCircular(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ],
          );
        });
  }

  checkInternet() async {
    bool connectionResult = await checkConnection(context);
    if (connectionResult == true) {
      BlocProvider.of<BlocInternet>(context).add(InternetFound());
    } else {
      // nointernet.NoInternet();
      BlocProvider.of<BlocInternet>(context).add(NoInternetFound());
    }

    return connectionResult;
  }

  checkConnection(BuildContext context) async {
    bool status = false;
    try {
      http.Response response =
          await http.get(Uri.parse('https://www.google.com/'));
      if (response.statusCode == 200) {
        status = true;
      } else {
        status = false;
      }
    } catch (e) {
      status = false;
    }
    return status;
  }
}
