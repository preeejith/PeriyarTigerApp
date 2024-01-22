import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class WaitingOTP extends LoginState {}

// class SMSError extends LoginState{
//   final ServerResponseModel serverResponseModel;
//   SMSError(this.serverResponseModel);
// }

class LoginInitial extends LoginState {}



class OtpInitialize extends LoginState {}

class LoginError extends LoginState {
  final String error;
  LoginError({required this.error});
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {}

class AuthNotConfirmed extends LoginState {
  final String? msg;
  AuthNotConfirmed({this.msg});
  @override
  List<Object> get props => [];
}

class AuthConfirmed extends LoginState {
  @override
  List<Object> get props => [];
}
