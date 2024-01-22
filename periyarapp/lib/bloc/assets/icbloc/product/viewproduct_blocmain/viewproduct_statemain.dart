
import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmainmodel.dart';







 class ViewProductMainState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewProductMainInitial extends ViewProductMainState {}

class ViewingProduct extends ViewProductMainState {}

class ViewProductMainSuccess extends ViewProductMainState {
  final ViewProductMainModel viewProductMainModel;
  ViewProductMainSuccess({required this.viewProductMainModel});
  @override
  List<Object> get props => [];
}

class ViewProductMainEmpty extends ViewProductMainState {
  @override
  List<Object> get props => [];
}

class ViewProductMainError extends ViewProductMainState {
  @override
  List<Object> get props => [];
}
