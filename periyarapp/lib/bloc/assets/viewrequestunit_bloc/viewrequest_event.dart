import 'package:equatable/equatable.dart';

class ViewRequestUnitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestUnit extends ViewRequestUnitEvent {
  final String? unitId;
 

  

  GetViewRequestUnit({
    this.unitId,
   
  });
  @override
  List<Object> get props => [];
}
// class GetViewRequestUnit2 extends ViewRequestUnitEvent {
//   final String? requestType;
 

  

//   GetViewRequestUnit2({
//     this.requestType,
   
//   });
//   @override
//   List<Object> get props => [];
// }