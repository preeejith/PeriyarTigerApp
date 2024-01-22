import 'package:equatable/equatable.dart';

class SearchAssetsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSearchAssets extends SearchAssetsEvent {
  final String? keyword;

  GetSearchAssets({
    this.keyword,
  });
  @override
  List<Object> get props => [];
}


class GetUnitSearchAssets extends SearchAssetsEvent {
  final String? keyword;

  GetUnitSearchAssets({
    this.keyword,
  });
  @override
  List<Object> get props => [];
}