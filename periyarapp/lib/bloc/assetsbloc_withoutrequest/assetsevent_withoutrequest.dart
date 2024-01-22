import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/assetsview_transfer.dart';

class AssetsWithoutRequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAssetsWithoutRequest extends AssetsWithoutRequestEvent {
  final String? transferedtoId;
  final List<TransferAssetsModel> transferassetslislist;

  GetAssetsWithoutRequest(
      {this.transferedtoId, required this.transferassetslislist});
  @override
  List<Object> get props => [];
}

class FetchAssetsWithoutRequest extends AssetsWithoutRequestEvent {
  final dynamic data;

  FetchAssetsWithoutRequest({this.data});
  @override
  List<Object> get props => [];
}
class RefreshAssetsWithoutRequest extends AssetsWithoutRequestEvent {
  final dynamic data;

  RefreshAssetsWithoutRequest({this.data});
  @override
  List<Object> get props => [];
}