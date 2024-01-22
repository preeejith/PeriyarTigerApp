//mainpage
///todya///
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:parambikulam/data/models/assetsmodel/productmain/viewproductmainmodel.dart';

import 'package:parambikulam/data/models/product/productlistmodel.dart';

import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

class ProductDetailedMainView extends StatefulWidget {
  final ViewProductMainModel? viewProductMainModel;

  final String? productid;

  final int index;
  const ProductDetailedMainView({
    Key? key,
    this.viewProductMainModel,
    this.productid,
    required this.index,
  }) : super(key: key);

  ///
  @override
  State<ProductDetailedMainView> createState() =>
      _ProductDetailedMainViewState();
}

///
var d1 = DateFormat('dd-MMM-yyyy');
var d2 = DateFormat('hh:mm a');
bool? editon = true;
// ProductsModel? productsModel;
bool? interneton = false;
List items51 = [];
bool? hassubunit = false;
List items58 = [];
List<ProductunitModel> productlist = [];
List<ProductunitModel> productunitunitlist = [];
ProductModel productModel = ProductModel(units: []);

List<ProductunitdataModel> productunitdatalist = [];
//import
List<ProductsubunitdataModel> productsubunitdatalist = [];

List<ProductsubunitModel> productsubunitunitlist = [];

///
List<Product2UnitModel> product2UnitModellist = [];

class _ProductDetailedMainViewState extends State<ProductDetailedMainView> {
  @override
  void initState() {
    testinternet();
    fetcher();

    super.initState();
  }

  final TextEditingController remarkcontroller = TextEditingController();
  void fetcher() async {
    productsubunitdatalist.clear();
    productsubunitunitlist.clear();
    productunitdatalist.clear();
    productunitunitlist.clear();
    productlist.clear();

    items58 = await getproductimagesdata();
    print(items58);
    items51 = await getproductmastertabletabledata();
    print(items51);
    List items54 = await getproductstocktabledata();
    print(items54);
    List items52 = await getproductunittabledata();
    print(items52);
    List items53 = await getproductsubunittabledata();
    print(items53);

    if (items51.isNotEmpty) {
      if (items51[widget.index]['hasUnit'] != "true") {
        if (items54.isNotEmpty) {
          for (int i = 0; i < items54.length; i++) {
            if (items51[widget.index]['_id'] == items54[i]['productid'] &&
                items54[i]['_id'] == items51[widget.index]['_id']) {
              productlist.add(ProductunitModel(
                  availablequantity: items54[i]['availableQuantity'],
                  productprice: items54[i]['price'],
                  productweight: items54[i]['weight'],
                  totalquantity: items54[i]['totalQuantity'],
                  productid: items54[i]['productid'],
                  date: items54[i]['date'],
                  unitid: items54[i]['_id']));
            }
          }
        }
      }

      ///4
      else if (items51[widget.index]['hasUnit'] == "true") {
        for (int k = 0; k < items52.length; k++) {
          if (items51[widget.index]['_id'] == items52[k]['productid']) {
            // hassubunit = true;
            productunitdatalist.add(ProductunitdataModel(
              productid: items52[k]['productid'],
              hassubunit: items52[k]['hassubUnit'],
              unitName: items52[k]['unitName'],
              date: items52[k]['date'],
            ));
          }

          ///3
          if (items52[k]['hassubUnit'] == "false") {
            for (int q = 0; q < items54.length; q++) {
              if (items52[k]['_id'] == items54[q]['_id']) {
                productunitunitlist.add(ProductunitModel(
                  availablequantity: items54[q]['availableQuantity'],
                  productid: items54[q]['productid'],
                  date: items54[q]['date'],
                  unitid: items54[q]['_id'],
                  productprice: items54[q]['price'],
                  productweight: items54[q]['weight'],
                  totalquantity: items54[q]['totalQuantity'],
                ));
              }
            }
          }

          ///2
          if (items52[k]['hassubUnit'] == "true") {
            for (int b = 0; b < items53.length; b++) {
              if (items51[widget.index]['_id'] == items53[b]['productid'] &&
                  items53[b]['subunitid'] == items52[k]['_id']) {
                productsubunitdatalist.add(
                  ProductsubunitdataModel(
                    id: items53[b]['_id'],
                    productid: items53[b]['productid'],
                    subunitid: items53[b]['subunitid'],
                    unitName: items53[b]['unitName'],
                    date: items53[b]['date'],
                  ),
                );
              }

              print(productsubunitdatalist);
              for (int l = 0; l < items54.length; l++) {
                if (items51[widget.index]['_id'] == items54[l]['productid'] &&
                    items53[b]['_id'] == items54[l]['_id']) {
                  productsubunitunitlist.add(ProductsubunitModel(
                    availablequantity: items54[l]['availableQuantity'],
                    productprice: items54[l]['price'],
                    productweight: items54[l]['weight'],
                    totalquantity: items54[l]['totalQuantity'],
                    productid: items54[l]['productid'],
                    subunitid: items54[l]['_id'],
                    date: items54[l]['date'],
                  ));
                }
              }
              //1
              print(productsubunitunitlist);
            }
          }
        }
        setState(() {});
      }
    }

    setState(() {});
  }

  void testinternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      interneton = false;
    } else if (connectivityResult != ConnectivityResult.none) {
      interneton = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: Text("Details"),
        actions: <Widget>[
          ////for reuse urgent
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ProductEditMain(
          //                 productname:
          //                     items51[widget.index]['productname'].toString(),
          //                 description:
          //                     items51[widget.index]['description'].toString(),
          //                 speciality:
          //                     items51[widget.index]['speciality'].toString(),
          //                 index: widget.index,
          //               )),
          //     );
          //   },
          //   child: Text(editon != true ? "" : "Edit",
          //       style: TextStyle(color: Colors.white)),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
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
                    //
                    children: [
                      // widget.index != items58.length - 1
                      //     ? SizedBox()
                      //     :
                      ///
                      items58.isNotEmpty
                          ? items58[widget.index]['imageurl'] == null
                              ? SizedBox()
                              : Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: new BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(
                                          items58[widget.index]['imageurl'],
                                        ),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                          : Container(
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

                      items51.isEmpty
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Name",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      // widget.index != items58.length - 1
                                      //     ? ""
                                      //     :
                                      items51[widget.index]['productname'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      items51.isEmpty
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child:
                                    //  widget.index != items58.length - 1
                                    //     ? SizedBox()
                                    //     :

                                    Text(
                                  "Description:" +
                                      "   " +
                                      items51[widget.index]['description'],
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                      items51.isEmpty
                          ? SizedBox()
                          :
                          //  widget.index != items58.length - 1
                          //     ? SizedBox()
                          //     :

                          items51[widget.index]['hasUnit'] == "true"
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total Quantity",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      widget.index != items58.length - 1
                                          ? SizedBox()
                                          : Text(
                                              productlist.isEmpty
                                                  ? ""
                                                  : productlist[0]
                                                      .totalquantity
                                                      .toString(),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                    ],
                                  ),
                                ),
                      //new chnages////
                      items51.isEmpty
                          ? SizedBox()
                          :
                          //  widget.index != items51.length - 1
                          //     ? SizedBox()
                          //     :

                          items51[widget.index]['hasUnit'] == "true"
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Available Quantity",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                        productlist.isEmpty
                                            ? ""
                                            : productlist[0]
                                                .availablequantity
                                                .toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                      items51.isEmpty
                          ? SizedBox()
                          : widget.index != items51.length - 1
                              ? SizedBox()
                              : items51[widget.index]['hasUnit'] == "true"
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Product Price",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Text(
                                            productlist.isEmpty
                                                ? ""
                                                : productlist[0]
                                                    .productprice
                                                    .toString(),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                      items51.isEmpty
                          ? SizedBox()
                          :
                          //  widget.index != items51.length - 1
                          //     ? SizedBox()
                          //     :
                          items51[widget.index]['hasUnit'] == "true"
                              ? Container()
                              : Padding(
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
                                        productlist.isEmpty
                                            ? ""
                                            : productlist[0]
                                                .productweight
                                                .toString(),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                      items51.isEmpty
                          ? SizedBox()
                          :
                          // widget.index != items51.length - 1
                          //     ? SizedBox()
                          //     :

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
                                    items51[widget.index]['unittype'],
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                      items51.isEmpty
                          ? SizedBox()
                          :
                          //  widget.index != items51.length - 1
                          //     ? SizedBox()
                          //     :

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
                                    items51[widget.index]['status'],
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: items51[widget.index]
                                                    ['status'] ==
                                                "Active"
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                ],
                              ),
                            ),
                      items51.isEmpty
                          ? SizedBox()
                          :
                          //  widget.index != items51.length - 1
                          //     ? SizedBox()
                          //     :

                          items51[widget.index]['speciality'] == ""
                              ? SizedBox.shrink()
                              // : widget.index != items51.length - 1
                              //     ? SizedBox()
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
                                        items51[widget.index]['speciality'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                      items51.isEmpty
                          ? SizedBox()
                          :
                          //  widget.index != items51.length - 1
                          //     ? SizedBox()
                          //     : widget.index != items51.length - 1
                          //         ? SizedBox()
                          //         :

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
                                    d1.format(DateTime.parse(convert(
                                            items51[widget.index]['date']))) +
                                        " | " +
                                        d2.format(DateTime.parse(convert(
                                            (items51[widget.index]['date'])))),
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              items51.isEmpty
                  ? SizedBox()
                  :
                  // widget.index != items51.length - 1
                  //     ? SizedBox()
                  //     :
                  items51[widget.index]['hasUnit'] != "true"
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
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
                              ],
                            ),
                          ),
                        ),
              items51.isEmpty
                  ? SizedBox()
                  :
                  //  widget.index != items51.length - 1
                  //     ? SizedBox()
                  //     :

                  items51[widget.index]['hasUnit'] != "true"
                      ? Container()
                      : Container(
                          child: Column(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: productunitdatalist.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      title: InkWell(
                                    child: Column(children: [
                                      InkWell(
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                2,
                                            decoration: BoxDecoration(
                                              color: Color(0xfff292929),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 4,
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        // productunitdatalist[index]
                                                        //             .hassubunit
                                                        //             .toString() !=
                                                        //         "true"
                                                        //     ? Container()
                                                        //     :

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24),
                                                              child: Container(
                                                                color: Colors
                                                                    .green,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    productunitdatalist[
                                                                            index]
                                                                        .unitName
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),

                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() ==
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Weight:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productunitunitlist[
                                                                            index]
                                                                        .availablequantity
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),

                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() ==
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Total Quantity:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productunitunitlist[
                                                                            index]
                                                                        .totalquantity
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        // state
                                                        //             .viewProductMainDetailedModel
                                                        //             .data![
                                                        //                 index]
                                                        //             .product !=
                                                        //         null
                                                        //     ? Container()
                                                        //     :
                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() ==
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Price:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productunitunitlist[
                                                                            index]
                                                                        .productprice
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        // productunitdatalist[index]
                                                        //             .hassubunit
                                                        //             .toString() !=
                                                        //         "true"
                                                        //     ? Container()
                                                        //     : Text(
                                                        //         productsubunitdatalist[
                                                        //                 0]
                                                        //             .unitName
                                                        //             .toString()),

                                                        ///next List
                                                        ///
                                                        ///
                                                        ///
                                                        ///
                                                        ///productsubunitdatalist
                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() !=
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Name:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productsubunitdatalist
                                                                            .isNotEmpty
                                                                        ? productsubunitdatalist[index]
                                                                            .unitName
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),

                                                        SizedBox(
                                                          height: 10,
                                                        ),

                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() !=
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "weight:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productsubunitunitlist
                                                                            .isNotEmpty
                                                                        ? productsubunitunitlist[index]
                                                                            .totalquantity
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() !=
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Total Quantity:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productsubunitunitlist
                                                                            .isNotEmpty
                                                                        ? productsubunitunitlist[index]
                                                                            .totalquantity
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),

                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        productunitdatalist[
                                                                        index]
                                                                    .hassubunit
                                                                    .toString() !=
                                                                "true"
                                                            ? Container()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Price:",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  Text(
                                                                    productsubunitunitlist
                                                                            .isNotEmpty
                                                                        ? productsubunitunitlist[index]
                                                                            .productprice
                                                                            .toString()
                                                                        : "",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {});
                                        },
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ]),
                                  ));
                                },
                              ),
                            ],
                          ),
                        )
            ],
          ),
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

class ProductModel {
  String? productname;
  String? id;
  String? description;
  String? unittype;
  String? status;
  String? date;
  String? hasUnit;
  String? speciality;
  String? totalQuatity;
  String? totalPrice;
  String? totalWeight;
  late List<Product2UnitModel> units = [];
  List<String>? image;
  List<String>? coverImage;
  // String? coverImage;

  ProductModel(
      {this.productname,
      this.id,
      this.status,
      this.date,
      this.hasUnit,
      this.description,
      this.totalPrice,
      this.totalQuatity,
      this.totalWeight,
      this.speciality,
      this.unittype,
      required this.units,
      this.image,
      this.coverImage});
}

class Product2UnitModel {
  String? unitName;
  String? stock;
  String? weight;
  String? price;
  List<Product2SubUnitModel>? subUnits = [];

  Product2UnitModel(
      {this.unitName, this.stock, this.weight, this.price, this.subUnits});
}

class Product2SubUnitModel {
  String? subUnitName;
  String? stock;
  String? weight;
  String? price;

  Product2SubUnitModel({
    this.subUnitName,
    this.stock,
    this.weight,
    this.price,
  });
}
/////////////////////////////

class ProductunitdataModel {
  String? id;
  // String? totalquantity;
  // String? availablequantity;
  // String? productprice;
  // String? productweight;
  String? productid;
  String? hassubunit;
  String? unitName;
  String? date;

  ProductunitdataModel({
    this.id,
    // this.totalquantity,
    // this.availablequantity,
    // this.productprice,
    // this.productweight,
    this.productid,
    this.hassubunit,
    this.unitName,
    this.date,
  });
}

class ProductsubunitdataModel {
  String? id;
  String? productid;
  String? subunitid;
  String? unitName;
  String? date;
  ProductsubunitdataModel({
    this.id,
    this.productid,
    this.subunitid,
    this.unitName,
    this.date,
  });
}

class ProductunitModel {
  String? totalquantity;
  String? unitid;
  String? productid;
  String? date;
  String? availablequantity;
  String? productprice;
  String? productweight;

  ProductunitModel(
      {this.availablequantity,
      this.productprice,
      this.productid,
      this.unitid,
      this.date,
      this.productweight,
      this.totalquantity});
}

class ProductsubunitModel {
  String? totalquantity;
  String? subunitid;
  String? productid;
  String? date;
  String? availablequantity;
  String? productprice;
  String? productweight;

  ProductsubunitModel(
      {this.availablequantity,
      this.productprice,
      this.productid,
      this.subunitid,
      this.date,
      this.productweight,
      this.totalquantity});
}
