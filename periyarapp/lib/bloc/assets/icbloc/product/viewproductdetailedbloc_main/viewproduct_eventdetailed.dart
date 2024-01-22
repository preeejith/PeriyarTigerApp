import 'package:equatable/equatable.dart';

class ViewProductMainDetailedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetViewProductMainDetailed extends ViewProductMainDetailedEvent {
  final String? productId;

  GetViewProductMainDetailed({
    this.productId,
  });
  @override
  List<Object> get props => [];
}
