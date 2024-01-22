import 'package:equatable/equatable.dart';

class ViewAssetDetailedsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewAssetDetailedEvent extends ViewAssetDetailedsEvent {
  final String? assetId;

  ViewAssetDetailedEvent({
    this.assetId,
  });
  @override
  List<Object> get props => [];
}
