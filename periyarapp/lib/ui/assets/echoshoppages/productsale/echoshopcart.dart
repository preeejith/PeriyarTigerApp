import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';


import 'package:parambikulam/bloc/assets/echoshop/echoShopCartManagementbloc.dart';
import 'package:parambikulam/ui/assets/bottomnavechoshop.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class EchoShopCart extends StatefulWidget {
  const EchoShopCart({Key? key}) : super(key: key);

  @override
  State<EchoShopCart> createState() => _EchoShopCartState();
}

class _EchoShopCartState extends State<EchoShopCart> {
  double totalAmount = 0;
  bool? isEmployee = false;
  String? ticketId = "";
  GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    BlocProvider.of<GetEchoShopCartManagementBloc>(context).add(ViewCart());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetEchoShopCartManagementBloc,
            EchoShopCartManagementState>(
        builder: ((context, state) {
          if (state is EchoShopCartView) {
            return state.cartData!.length == 0
                ? Scaffold(
                    body: Center(
                      child: Text("No Items in cart"),
                    ),
                  )
                : Scaffold(
                    bottomNavigationBar: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        child: Text(
                          'Add Sale',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        height: 52,
                        onPressed: () {
                          Map data = {
                            
                            "ticketId": ticketId,
                            "isEmployee": isEmployee,
                            "items": state.cartData,
                            "totalAmount": isEmployee!
                                ? (calculateTotal(state.cartData) -
                                    (calculateTotal(state.cartData) * .1))
                                : calculateTotal(state.cartData)
                          };
                          BlocProvider.of<GetEchoShopCartManagementBloc>(
                                  context)
                              .add(PlaceOrder(data: data));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EchoShopBottomNavigation()),
                              (Route<dynamic> route) => false);
                          context
                              .read<GetEchoShopCartManagementBloc>()
                              .cartData = [];
                        },
                        color: Color(0xff53A874),
                        minWidth: MediaQuery.of(context).size.width * .6,
                      ),
                    ),
                    appBar: new AppBar(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text('Cart'),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: IconButton(
                              icon:ticketId!=""?Icon(Icons.check,color: Color(0xff53A874),): Icon(Icons.qr_code_scanner_outlined),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (contextAlert) {
                                      return AlertDialog(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Icon(CupertinoIcons.multiply),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon:
                                                  Icon(CupertinoIcons.multiply),
                                            )
                                          ],
                                        ),
                                        backgroundColor: Colors.transparent,
                                        content: SizedBox(
                                          height: 250.0,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(16.0)),
                                            child: QRView(
                                              key: qrKey,
                                              onQRViewCreated:
                                                  (qrViewController) {
                                                qrViewController
                                                    .scannedDataStream
                                                    .listen((scanData) {
                                                  if (scanData.code!.contains(
                                                      'ticketbyticketpdf')) {
                                                    qrViewController
                                                        .stopCamera();
                                                    ticketId = scanData.code!
                                                        .split("=")
                                                        .last;
                                                        setState(() {
                                                          
                                                        });
                                                        Vibrate.feedback(FeedbackType.medium);
                                                    Navigator.pop(context);
                                                  }
                                                });
                                              },
                                              //    _onQRViewCreated,
                                              overlay: QrScannerOverlayShape(
                                                borderColor: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        )
                      ],
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.cartData!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title: Text(
                                      state.cartData![index]['productName']),
                                  subtitle: Text(
                                      " ${state.cartData![index]['quantity']} X ${state.cartData![index]['totalamount']}"),
                                  trailing: Text(
                                      "Rs. ${double.parse(state.cartData![index]['quantity'].toString()) * double.parse(state.cartData![index]['totalamount'].toString())}"));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                tileColor: Colors.white,
                                title: Text(
                                  'Item Total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Text(
                                  ' Rs. ${isEmployee! ? (calculateTotal(state.cartData) - (calculateTotal(state.cartData) * .1)) : calculateTotal(state.cartData)} ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )),
                          ),
                          ListTile(
                              title: Text(
                                'Apply Employee Discount (10%)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              trailing: Checkbox(
                                value: isEmployee,
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  setState(() {
                                    Vibrate.feedback(FeedbackType.medium);

                                    isEmployee = !isEmployee!;
                                  });
                                },
                              )),
                        ],
                      ),
                    ));
          } else {
            return Container();
          }
        }),
        listener: ((context, state) {}));
  }

  calculateTotal(cartData) {
    totalAmount = 0;
    for (int i = 0; i < cartData!.length; i++) {
      totalAmount = totalAmount +
          double.parse(cartData![i]['quantity'].toString()) *
              double.parse(cartData![i]['totalamount'].toString());
    }
    return totalAmount;
  }
}
