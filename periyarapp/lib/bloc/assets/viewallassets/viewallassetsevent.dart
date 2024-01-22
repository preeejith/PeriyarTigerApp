import 'package:equatable/equatable.dart';

class ViewallAssetsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewallAssetsEvent extends ViewallAssetsEvent {
  final dynamic data;

  GetViewallAssetsEvent({this.data});
  @override
  List<Object> get props => [];
}
class FetchViewallAssetsEvent extends ViewallAssetsEvent {
  final dynamic data;

  FetchViewallAssetsEvent({this.data});
  @override
  List<Object> get props => [];
}

class FetchAssetsdataEvent extends ViewallAssetsEvent {
  final dynamic data;

  FetchAssetsdataEvent({this.data});
  @override
  List<Object> get props => [];
}

class GetUnitSearchAssets extends ViewallAssetsEvent {
  final String? keyword;

  GetUnitSearchAssets({
    this.keyword,
  });
  @override
  List<Object> get props => [];
}

class RefreshViewallAssetsEvent extends ViewallAssetsEvent {
  final dynamic data;

  RefreshViewallAssetsEvent({this.data});
  @override
  List<Object> get props => [];
}
class RefreshingUnitSearchAssets extends ViewallAssetsEvent {
  final dynamic data;

  RefreshingUnitSearchAssets({this.data});
  @override
  List<Object> get props => [];
}