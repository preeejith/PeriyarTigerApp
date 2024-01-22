import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

import 'package:parambikulam/data/models/assetsmodel/new/requestviewmainmodel.dart';

class ViewRequestMainState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewRequestMainInitial extends ViewRequestMainState {}

class Checking extends ViewRequestMainState {}

class ViewRequestMainSuccess extends ViewRequestMainState {
  final ViewRequestMainModel viewRequestMainModel;
  ViewRequestMainSuccess({required this.viewRequestMainModel});
  @override
  List<Object> get props => [];
}

class RefreshRequestMainEmpty extends ViewRequestMainState {}

class ViewRequestMainEmpty extends ViewRequestMainState {
  @override
  List<Object> get props => [];
}

class GettingdataSuccess extends ViewRequestMainState {
  final List items42;
  final List items43;
  final List items44;
  final List items45;
  final List items46;
  final List<ViewassetsModel> viewassetsModel;
  final List<AssetMasterTable> assetMasterTable;

  GettingdataSuccess(
      {required this.items42,
      required this.items43,
      required this.items44,
      required this.items45,
      required this.items46,
      required this.assetMasterTable,
      required this.viewassetsModel});
  @override
  List<Object> get props => [];
}


class RequestDataDownloadedSuccesfully extends ViewRequestMainState {
  @override
  List<Object> get props => [];
}
class ViewRequestMainError extends ViewRequestMainState {
  @override
  List<Object> get props => [];
}
