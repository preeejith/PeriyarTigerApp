import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';
import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';

class ViewallAssetsState extends Equatable {
  @override
  List<Object> get props => [];
}

////
class ViewallAssetsInitial extends ViewallAssetsState {}
class SearchAssetsing extends ViewallAssetsState {}
class Checking extends ViewallAssetsState {}

class ViewallAssetsSuccess extends ViewallAssetsState {
  final ViewAllAssetsModel viewAllAssetsModel;
  ViewallAssetsSuccess({required this.viewAllAssetsModel});
  @override
  List<Object> get props => [];
}
class SearchAssetssuccess extends ViewallAssetsState {
  final List<ViewassetsModel> viewassetssearchModel;
  final List<AssetMasterTable> assetMasterSuggestion;
  SearchAssetssuccess({required this.viewassetssearchModel,required this.assetMasterSuggestion});
  @override
  List<Object> get props => [];
}


class FetchAssetsSuccess extends ViewallAssetsState {
  final List<ViewassetsModel> viewassetsModel;
   final List<AssetMasterTable> assetMasterTable;


  FetchAssetsSuccess({required this.viewassetsModel,required this.assetMasterTable});
  @override
  List<Object> get props => [];
}
class RefreshStateCommon extends ViewallAssetsState {}
class RefreshStateDownload extends ViewallAssetsState {}
class DownloadedSuccess extends ViewallAssetsState {}
class NoDataStateCommon extends ViewallAssetsState {}

class ViewallAssetsEmpty extends ViewallAssetsState {
  @override
  List<Object> get props => [];
}

class ViewallAssetsError extends ViewallAssetsState {
  @override
  List<Object> get props => [];
}
