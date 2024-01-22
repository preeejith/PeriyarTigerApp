import 'package:equatable/equatable.dart';
import 'package:parambikulam/bloc/assets/echoshop/viewmyrequestbloc/viewmyrequestbloc.dart';
import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestviewmodel.dart';

//new//
class ViewMyRequestState extends Equatable {
  @override
  List<Object> get props => [];
}

///
class ViewMyRequestInitial extends ViewMyRequestState {}

class Viewmyrequest extends ViewMyRequestState {}
class ViewmyrequestDownloaded extends ViewMyRequestState {}
class Refreshmyrequest extends ViewMyRequestState {}

class ViewMyRequestSuccess extends ViewMyRequestState {
  final MyRequestViewModel myRequestViewModel;
  final List<OfflineRequestModel> offlineRequestlist;
  ViewMyRequestSuccess(
      {required this.myRequestViewModel, required this.offlineRequestlist});
  @override
  List<Object> get props => [];
}

class ViewMyRequestSuccess2 extends ViewMyRequestState {
  final MyRequestViewModel myRequestViewModel;

  ViewMyRequestSuccess2({required this.myRequestViewModel});
  @override
  List<Object> get props => [];
}

class ViewMyRequestEmpty extends ViewMyRequestState {
  @override
  List<Object> get props => [];
}

class ViewMyRequestError extends ViewMyRequestState {
  @override
  List<Object> get props => [];
}
