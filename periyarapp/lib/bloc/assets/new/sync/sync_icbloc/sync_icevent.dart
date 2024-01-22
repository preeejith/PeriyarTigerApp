import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/ic_main/viewrequestmaindetailed.dart';

class SyncOfflineDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSyncOfflineData extends SyncOfflineDataEvent {
  final String? requestId;

  final List<RequestModel> requestlist;

  GetSyncOfflineData({this.requestId, required this.requestlist});
  @override
  List<Object> get props => [];
}

class FetchSyncOfflineData extends SyncOfflineDataEvent {
  final dynamic data;

  FetchSyncOfflineData({this.data});
  @override
  List<Object> get props => [];
}

class FetchSyncallData extends SyncOfflineDataEvent {
  final dynamic data;

  FetchSyncallData({this.data});
  @override
  List<Object> get props => [];
}

class GetProductEditData extends SyncOfflineDataEvent {
  final dynamic data;

  GetProductEditData({this.data});
  @override
  List<Object> get props => [];
}

class GetSyncAssetsEditData extends SyncOfflineDataEvent {
  final dynamic data;

  GetSyncAssetsEditData({this.data});
  @override
  List<Object> get props => [];
}
