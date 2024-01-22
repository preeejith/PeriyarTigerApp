import 'package:equatable/equatable.dart';

class ProductDeleteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProductDelete extends ProductDeleteEvent {
  final dynamic data;

  GetProductDelete({
    this.data,
  });
  @override
  List<Object> get props => [];
}
