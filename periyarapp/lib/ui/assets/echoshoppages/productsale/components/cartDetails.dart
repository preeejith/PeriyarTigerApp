import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoShopCartManagementbloc.dart';
import 'package:parambikulam/ui/assets/echoshoppages/productsale/echoshopcart.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({Key? key}) : super(key: key);

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  void initState() {
    BlocProvider.of<GetEchoShopCartManagementBloc>(context).add(ViewCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.read<GetEchoShopCartManagementBloc>().cartData!.length == 0
        ? SizedBox.shrink()
        : Container(
            height: 75,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 41, 152, 84),
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(15.0))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                      child: Column(
                        children: [
                          Text(
                            "Rs ${calculateTotal(context.read<GetEchoShopCartManagementBloc>().cartData!)}",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'RobotoM',
                                fontSize: 14),
                          ),
                          Text(
                              " ${context.read<GetEchoShopCartManagementBloc>().cartData!.length} ITEMS TOTAL",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10))
                        ],
                      ),
                    )),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: InkWell(
                      child: Row(
                        children: [
                          Text(
                            "View Cart",
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EchoShopCart()));
                      },
                    ),
                  ),
                )
              ],
            ));
  }

  calculateTotal(cartData) {
    double totalAmount = 0;
    for (int i = 0; i < cartData!.length; i++) {
      totalAmount = totalAmount +
          double.parse(cartData![i]['quantity'].toString()) *
              double.parse(cartData![i]['totalamount'].toString());
    }
    return totalAmount;
  }
}
