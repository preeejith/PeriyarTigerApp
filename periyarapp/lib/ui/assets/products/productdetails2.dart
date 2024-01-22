//mainpage

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_blocdetailed.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_eventdetailed.dart';
import 'package:parambikulam/bloc/assets/icbloc/product/viewproductdetailedbloc_main/viewproduct_statedetailed.dart';
import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmainmodel.dart';
import 'package:parambikulam/data/models/product/productlistmodel.dart';
import 'package:parambikulam/ui/assets/ic_main/addproductmain.dart';

class ProductDetails2 extends StatefulWidget {
  final ViewProductMainModel viewProductMainModel;
  final String productid;
  final String index;
  const ProductDetails2({
    Key? key,
    required this.viewProductMainModel,
    required this.productid,
    required this.index,
  }) : super(key: key);

  @override
  State<ProductDetails2> createState() => _ProductDetails2();
}

var d1 = DateFormat('dd-MMM-yyyy');
var d2 = DateFormat('hh:mm a');

class _ProductDetails2 extends State<ProductDetails2> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  final TextEditingController remarkcontroller = TextEditingController();
  void fetcher() async {
    BlocProvider.of<GetViewProductMainDetailedBloc>(context)
        .add(GetViewProductMainDetailed(productId: "626cd566f9beeb3c6c5804f1"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: Text("Details"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddProductMain()));
            },
            child: Text("Edit", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<GetViewProductMainDetailedBloc,
            ViewProductMainDetailedState>(
          builder: (context, state) {
            if (state is ViewProductMainDetailedsuccess) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3.5,
                              width: MediaQuery.of(context).size.width,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage("assets/echobag.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Name",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget
                                        .viewProductMainModel
                                        .data![int.parse(widget.index)]
                                        .productname
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Description:" +
                                    "   " +
                                    widget
                                        .viewProductMainModel
                                        .data![int.parse(widget.index)]
                                        .description
                                        .toString(),
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Quantity",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget
                                        .viewProductMainModel
                                        .data![int.parse(widget.index)]
                                        .productname
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Available Quantity",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  // Text(
                                  //   state.viewProductMainDetailedModel.data![0]
                                  //       .totalQuantity
                                  //       .toString(),
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Price",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  // Text(
                                  //   state.viewProductMainDetailedModel.data![0]
                                  //       .price
                                  //       .toString(),
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Weight",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.viewProductMainModel
                                        .data![int.parse(widget.index)].weight
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Unit Type",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.viewProductMainModel
                                        .data![int.parse(widget.index)].unitType
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status of Product",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.viewProductMainModel.data![0].status
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: widget.viewProductMainModel
                                                    .data![0].status ==
                                                "Active"
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            widget.viewProductMainModel.data![0].speciality!
                                    .isEmpty
                                ? SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Speciality",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        Text(
                                          widget
                                              .viewProductMainModel
                                              .data![int.parse(widget.index)]
                                              .productname
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Created Date",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    widget.viewProductMainModel.data![0]
                                        .productname
                                        .toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                           
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 4,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Product Types",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),

                            // addedunitlist(state.viewProductMainDetailedModel.data),
                          ],
                        ),
                      ),
                    ),
///////////////////////////////////////////////////////
                    ///
                    ///

//list start
                    Column(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              state.viewProductMainDetailedModel.data!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            print(state
                                .viewProductMainDetailedModel.data!.length);
                            return Container();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {},
        ),
      ),
    );
  }

  Widget addedunitlist(List<Units>? units) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: units!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(units[index].type.toString()),
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
                                      "Quantity  :",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      units[index].stock.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
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
                                      "Price  :",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      units[index].price.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
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
                                      "Weight  :",
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      units[index].weight.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ]),
                            ),
                            units[index].type != null
                                ? addedSubUnitslist(units[index].size)
                                : SizedBox.shrink(),
                          ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Colors.white,
                ),
              ],
            );
          }),
    );
  }

  Widget addedSubUnitslist(List<Size>? subUnits) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: subUnits!.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
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
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(subUnits[index].sizename.toString()),
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: const Text(
                                    "SubType Quantity  :",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subUnits[index].stock.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: const Text(
                                    "SubType Price  :",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subUnits[index].price.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: const Text(
                                    "SubType Weight  :",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    subUnits[index].weight.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            );
          }),
    );
  }

  String convert(String uTCTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(uTCTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    return localDate;
  }
}
