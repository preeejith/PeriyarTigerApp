import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/bookingdetails.dart';

class EventUpload extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GettingImage extends EventUpload {
  final String? path, idOrNum, idOffline;
  final BookingDetails? id;
  final int? iCount;
  final bool? isOffline;
  final String? pdfId;
  GettingImage({this.path, required this.isOffline,this.idOffline, this.id, this.iCount, this.idOrNum, this.pdfId});
}
