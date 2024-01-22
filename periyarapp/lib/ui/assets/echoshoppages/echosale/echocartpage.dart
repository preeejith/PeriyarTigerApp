import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoshopsalebloc/echoshopsalebloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoshopsalebloc/echoshopsaleevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/echoshopsalebloc/echoshopsalestate.dart';
import 'package:parambikulam/ui/assets/bottomnavechoshop.dart';
import 'package:parambikulam/ui/assets/echoshoppages/echoassetsview.dart';


class EchoCart extends StatefulWidget {
  final List<ItemtocartModel> itemaddtocartlist;

  const EchoCart({Key? key, required this.itemaddtocartlist}) : super(key: key);

  @override
  State<EchoCart> createState() => _EchoCartState();
}

class _EchoCartState extends State<EchoCart> {
  int sum = 0;
  @override
  void initState() {
    super.initState();
    initFunc();
  }

  initFunc() {
    for (int i = 0; i < widget.itemaddtocartlist.length; i++) {
      sum = sum + int.parse(widget.itemaddtocartlist[i].totalamount.toString());
    }
    print(sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Echo Cart"), actions: []),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: Column(
          children: [
            Container(
              height: 30,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Grand Total  :",
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                      Row(
                        children: [
                          Text(
                            sum.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),

                          //   Text(widget.itemaddtocartlist[index]
                          // .salesPrice
                          // .toString(),style: TextStyle(fontSize: 12,color: Colors.black),),
                        ],
                      )
                    ]),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              height: 40,
              minWidth: 300,

              onPressed: () {
                if (widget.itemaddtocartlist.isEmpty) {
                  Fluttertoast.showToast(msg: "Please add Items to Cark");
                } else {
                  validateData();
                }

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => SnareDetails()));
              },

              child: BlocConsumer<GetEchoShopSaleBloc, EchoShopSaleState>(
                  builder: (context, state) {
                if (state is EchoShopSaleing) {
                  return const SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      strokeWidth: 2,
                    ),
                  );
                } else {
                  return const Text(
                    "SALE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  );
                }
              }, listener: (context, state) {
                if (state is EchoShopSalesuccess) {
                  // groupid = state.snareWalkStartModel.data!.id;

                  Fluttertoast.showToast(msg: "Assets Selled");

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EchoShopBottomNavigation()));
                }
              }),

              // color: AppStyles.appColor,
              color: const Color(0xff59AF73),
            ),
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: widget.itemaddtocartlist.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(""),
                                        InkWell(
                                          child: const Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.grey),
                                          onTap: () {
                                            setState(() {
                                              widget.itemaddtocartlist
                                                  .removeWhere((item) =>
                                                      item.id ==
                                                      widget
                                                          .itemaddtocartlist[
                                                              index]
                                                          .id);
                                            });

                                            // participantlislist.removeAt(0);
                                          },
                                        ),
                                      ]),
                                ),

                                // Text("Hello"),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Name  :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          widget.itemaddtocartlist[index].name
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Quantity  :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          widget
                                              .itemaddtocartlist[index].quantity
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Type  :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          widget.itemaddtocartlist[index].type
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Sale Price  :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          widget.itemaddtocartlist[index]
                                              .salesPrice
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Total Price  :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              widget.itemaddtocartlist[index]
                                                  .totalamount
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),

                                            //   Text(widget.itemaddtocartlist[index]
                                            // .salesPrice
                                            // .toString(),style: TextStyle(fontSize: 12,color: Colors.black),),
                                          ],
                                        )
                                      ]),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
// Text(widget.itemaddtocartlist.length.toString(),style: TextStyle(color: Colors.black),),

                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
            ),
            //  Padding(
            //                                 padding: const EdgeInsets.all(4.0),
            //                                 child: Row(
            //                                     mainAxisAlignment:
            //                                         MainAxisAlignment.spaceBetween,
            //                                     children: [
            //                                       const Text(
            //                                         "Grand Total  :",
            //                                         style: TextStyle(
            //                                             fontSize: 12, color: Colors.black),
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                               Text(
            //                                             widget.sum
            //                                                 .toString(),
            //                                             style: TextStyle(
            //                                                 fontSize: 12,
            //                                                 color: Colors.black),
            //                                           ),

            //                                           //   Text(widget.itemaddtocartlist[index]
            //                                           // .salesPrice
            //                                           // .toString(),style: TextStyle(fontSize: 12,color: Colors.black),),
            //                                         ],
            //                                       )
            //                                     ]),
            //                               ),
            // Text(widget.itemaddtocartlist)
          ]),
        ),
      ),
    );
  }

  void validateData() {
    BlocProvider.of<GetEchoShopSaleBloc>(context).add(GetEchoShopSale(
      ticketNo: "1003",
      isEmployee: "false",
      totalAmount: "100",
      itemaddtocartlist: widget.itemaddtocartlist,
    ));
  }
}
