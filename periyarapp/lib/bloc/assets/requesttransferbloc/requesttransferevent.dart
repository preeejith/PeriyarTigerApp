import 'package:equatable/equatable.dart';

class TransferRequestEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTransferRequest extends TransferRequestEvent {
  final String? requestId;
    final String? assetId;
        final String? quantity;
 

  

  GetTransferRequest({
    this.requestId,
      this.assetId,
         this.quantity
   
  });
  @override
  List<Object> get props => [];
}
