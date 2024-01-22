import 'package:equatable/equatable.dart';


class AssetsTransferMainEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAssetsTransferMain extends AssetsTransferMainEvent {
  final String? purchaseId;
  final String? transferedtoId;

  //  final List<AssetsTransferMainsModel> AssetsTransferMainslist;

  GetAssetsTransferMain({
    this.purchaseId,
    this.transferedtoId,

    // required this.AssetsTransferMainslist
  });
  @override
  List<Object> get props => [];
}
