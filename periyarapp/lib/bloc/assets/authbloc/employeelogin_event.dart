import 'package:equatable/equatable.dart';


 class EmployeeloginEvent extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class Employeeloginentry extends EmployeeloginEvent {
  final String? phonenumber;
  final String? password;



  // final String? startlon;

  Employeeloginentry(
      {this.phonenumber,
      this.password,

   
      
      });
  // @override
  // List<Object> get props => [];
}
