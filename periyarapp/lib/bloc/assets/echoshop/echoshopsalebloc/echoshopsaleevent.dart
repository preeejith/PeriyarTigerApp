import 'package:equatable/equatable.dart';
import 'package:parambikulam/ui/assets/echoshoppages/echoassetsview.dart';

class EchoShopSaleEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetEchoShopSale extends EchoShopSaleEvent {
  final String? ticketNo;
    final String? isEmployee;
 
    final String? totalAmount;
     final List<ItemtocartModel> itemaddtocartlist;
  

  GetEchoShopSale({
    this.ticketNo,
      this.isEmployee,
          this.totalAmount,
                required this.itemaddtocartlist
   
  });
  @override
  List<Object> get props => [];
}
