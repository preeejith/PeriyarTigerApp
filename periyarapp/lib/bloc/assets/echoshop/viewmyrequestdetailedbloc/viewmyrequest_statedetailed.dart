import 'package:equatable/equatable.dart';

import 'package:parambikulam/data/models/assetsmodel/echoshopmodel/myrequestdetailedmodel.dart';

class ViewMyRequestDetailedState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewMyRequestDetailedInitial extends ViewMyRequestDetailedState {}

class ReportGenerating extends ViewMyRequestDetailedState {}

class ViewMyRequestDetailedSuccess extends ViewMyRequestDetailedState {
  final MyrequestDetailedModel myrequestDetailedModel;
  ViewMyRequestDetailedSuccess({required this.myrequestDetailedModel});
  @override
  List<Object> get props => [];
}

class ViewMyRequestDetailedEmpty extends ViewMyRequestDetailedState {
  @override
  List<Object> get props => [];
}

class ViewMyRequestDetailedError extends ViewMyRequestDetailedState {
  @override
  List<Object> get props => [];
}
