import 'package:equatable/equatable.dart';

class StateSyncOffline extends Equatable {
  @override
  List<Object?> get props => [];
}

class BlocSyncOfflineInitial extends StateSyncOffline {}

class CheckingSync extends StateSyncOffline {}

class BusDataUploading extends StateSyncOffline {}
class BusDataUploadedState extends StateSyncOffline {}

class DataFoundState extends StateSyncOffline {
  final int? length, failedLength,busLength;
  DataFoundState({this.length, this.failedLength, this.busLength});
}

class DataNotFoundState extends StateSyncOffline {}

class UploadingData extends StateSyncOffline {}

class UploadingFinishedState extends StateSyncOffline {}

class UploadingNotFinishedState extends StateSyncOffline {
  final int? length;
  UploadingNotFinishedState({required this.length});
}

class NoInternetState extends StateSyncOffline {}

class ShowFailedData extends StateSyncOffline {
  final List? finalList;
  ShowFailedData({this.finalList});
}
