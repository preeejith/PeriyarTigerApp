///bloc chnaged

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/auth/auth_event.dart';
import 'package:parambikulam/bloc/repositories/authrepository.dart';
import 'package:parambikulam/data/models/server_response_model.dart';
import 'package:parambikulam/utils/pref_manager.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<GetOTP>(_getOTP);
    on<AuthCheck>(_authCheck);
  }
  Future<FutureOr<void>> _getOTP(
      GetOTP event, Emitter<LoginState> emit) async {
        
    ServerResponseModel serverResponseModel;
    Map map = {
      "accessType": "signin",
      "phone": event.number,
      "otp": event.password,
      "role": "guest",
    };
    var url = '/user/signup/employeesignin';
    serverResponseModel = await AuthRepository().login(url: url, data: map);

    if (serverResponseModel.status == true) {
      await PrefManager.setToken(serverResponseModel.token);
      // print(serverResponseModel.token);
      await PrefManager.setCurrentRole(serverResponseModel.role.toString());
      await PrefManager.setCurrentUser(
          serverResponseModel.userdata!.user!.email.toString());
      emit(LoginSuccess());
    }
  }

  Future<FutureOr<void>> _authCheck(
      AuthCheck event, Emitter<LoginState> emit) async {
    final token = await PrefManager.getToken();

    emit(token == null ? AuthNotConfirmed(msg: "Token NUll") : AuthConfirmed());
  }

  /////old oneee
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   if (event is AuthCheck) {
  //     final token = await PrefManager.getToken();
  //     // print("User Token : " + token + " : ");
  //     yield token == null
  //         ? AuthNotConfirmed(msg: "Token NUll")
  //         : AuthConfirmed();
  //   }

  //   if (event is GetOTP) {
  //     yield OtpInitialize();
  //     ServerResponseModel serverResponseModel;
  //     // User user;
  //     Map map = {
  //       "accessType": "signin",
  //       "phone": event.number,
  //       "otp": event.password,
  //       "role": "guest",
  //     };
  //     serverResponseModel = await AuthRepository()
  //         .login(url: '/user/signup/employeesignin', data: map);

  //     if (serverResponseModel.status == true) {
  //       await PrefManager.setToken(serverResponseModel.token);
  //       // print(serverResponseModel.token);
  //       await PrefManager.setCurrentRole(serverResponseModel.role.toString());
  //       await PrefManager.setCurrentUser(
  //           serverResponseModel.userdata!.user!.email.toString());
  //       yield LoginSuccess();
  //     }

  //     else {
  //       yield LoginError(error: serverResponseModel.msg.toString());
  //     }
  //   }
  // }
}
