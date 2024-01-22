// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:parambikulam/data/models/assetsmodel/icmodels/viewallassetsmodel.dart';

class AssetsEditDetailedsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AssetsEditDetailedEvent extends AssetsEditDetailedsEvent {
  final String? assetId;
  final List<ViewassetsModel> viewassetsModel;
  final List<AssetMasterTable> assetMasterTable;
  final String? name;

  final String? description;

  AssetsEditDetailedEvent({
    this.assetId,
    required this.assetMasterTable,
    required this.viewassetsModel,
    this.name,
    this.description,
  });
  @override
  List<Object> get props => [];
}

class FetchAssetsEditDetailedEvent extends AssetsEditDetailedsEvent {
  dynamic data;

  FetchAssetsEditDetailedEvent({this.data});
  @override
  List<Object> get props => [];
}
