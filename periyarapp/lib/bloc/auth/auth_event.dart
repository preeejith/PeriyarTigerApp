import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthCheck extends LoginEvent {
  @override
  List<Object> get props => [];
}

class GetOTP extends LoginEvent {
  final String number, password;
  GetOTP({required this.number, required this.password});
  @override
  List<Object> get props => [];
}

class CheckStatus extends LoginEvent {}


