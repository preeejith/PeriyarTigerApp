import 'package:equatable/equatable.dart';

class EventSyncOffline extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadEventInitial extends EventSyncOffline {}

class UploadFailedData extends EventSyncOffline {
  final List? finalList;
  UploadFailedData({required this.finalList});
}

class DataFound extends EventSyncOffline {
  final int? length, failedLength, busUploadLength;
  DataFound({this.length, this.failedLength, this.busUploadLength});
}

class DataNotFound extends EventSyncOffline {}

class UploadingBusData extends EventSyncOffline {}

class BusDataUploaded extends EventSyncOffline {}
//

class UploadingInitiated extends EventSyncOffline {}

class UploadingFinished extends EventSyncOffline {}

class UploadingNotFinished extends EventSyncOffline {
  final int? length;
  UploadingNotFinished({required this.length});
}

class NoInternet extends EventSyncOffline {}

class GetFailedData extends EventSyncOffline {
  final List? finalList;
  GetFailedData({this.finalList});
}
