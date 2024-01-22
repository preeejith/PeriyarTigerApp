import 'package:equatable/equatable.dart';

class StateUpload extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class BlocUploadInitial extends StateUpload {}

class ProcessingImage extends StateUpload {}

class ImageUploaded extends StateUpload {
  final int? iCount;
  ImageUploaded({this.iCount});
}

class ImageUploadFailed extends StateUpload {
   final int? iCount;
  ImageUploadFailed({this.iCount});
}
