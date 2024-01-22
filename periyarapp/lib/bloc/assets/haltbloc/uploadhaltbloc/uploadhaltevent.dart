import 'package:equatable/equatable.dart';

import 'package:parambikulam/ui/assets/ic_main/halt/haltdetails.dart';

class UploadHalt2Event extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadHaltEvent extends UploadHalt2Event {
 final List<Halt2UploadModel> halt2uploadlist;

  UploadHaltEvent({
     required this.halt2uploadlist
  });
  @override
  List<Object> get props => [];
}
