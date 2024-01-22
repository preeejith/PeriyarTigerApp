import 'package:equatable/equatable.dart';

class ViewRequestUnittypeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewRequestUnittype extends ViewRequestUnittypeEvent {
  final String? requestType;
 

  

  GetViewRequestUnittype({
    this.requestType,
   
  });
  @override
  List<Object> get props => [];
}
