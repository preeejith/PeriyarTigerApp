import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parambikulam/bloc/assets/addassetsbloc/addassetsbloc.dart';
import 'package:parambikulam/bloc/assets/addassetsbloc/addassetsevent.dart';
import 'package:parambikulam/bloc/assets/addassetsbloc/addassetsstate.dart';
import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditbloc.dart';

import 'package:parambikulam/bloc/assets/assetseditbloc/assetseditstate.dart';

import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';

import 'package:parambikulam/ui/assets/profilepage.dart';

import 'package:parambikulam/utils/pref_manager.dart';

class StaysHomePage extends StatefulWidget {
  const StaysHomePage({Key? key}) : super(key: key);

  @override
  State<StaysHomePage> createState() => _StaysHomePageState();
}

class _StaysHomePageState extends State<StaysHomePage> {
  String? token;
  String dropdownvalue = 'Non consumable';
  var items = [
    'Non consumable',
    'Consumable',
  ];

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();

  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();

  @override
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    // token = await PrefManager.getToken();
    BlocProvider.of<GetViewallAssetsBloc>(context).add(GetViewallAssetsEvent());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: theDrawer(),
      appBar: new AppBar(
        title: new Text('Stays Home'),
        // leading: InkWell(onTap: () {}, child: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              PrefManager.clearToken();

              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
            icon: Icon(
              Icons.logout_outlined,
              size: 18,
            ),
          ),
          IconButton(
            onPressed: () {
              print("yes");
              // synData(context, state);
            },
            icon: Icon(Icons.sync_outlined),
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage(
                    "assets/bgptrr.png",
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
                builder: (context, state) {
                  if (state is ViewallAssetsSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Assets Details",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: MaterialButton(
                                  height: 30,
                                  minWidth: 10,
                                  child: const Text(
                                    'Add Assets',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: SizedBox(
                                            child: AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              title: const Text('Add Assets'),
                                              content: Column(children: [
                                                Column(
                                                  children: [
                                                    TextFormField(
                                                      //noted
                                                      controller:
                                                          namecontroller,
                                                      autocorrect: true,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Asset Name',
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Text("Product Type"),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    // TextFormField(
                                                    //             controller:
                                                    //                 producttypecontroller,
                                                    //             autocorrect: true,
                                                    //             keyboardType:
                                                    //                 TextInputType.text,
                                                    //             decoration:
                                                    //                 const InputDecoration(
                                                    //               labelText:
                                                    //                   'Product Type',
                                                    //             ),
                                                    //           ),

                                                    DropdownButtonFormField(
                                                      focusColor: Colors.black,
                                                      decoration:
                                                          InputDecoration(

                                                              //  hintText: "Gender",
                                                              isDense: true,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              border:
                                                                  InputBorder
                                                                      .none),

                                                      // Initial Value
                                                      value: dropdownvalue,

                                                      // Down Arrow Icon
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),

                                                      // Array list of items
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(
                                                            items,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey),
                                                            //  style: AppStyles.heading,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // After selecting the desired option,it will
                                                      // change button value to selected value
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          dropdownvalue =
                                                              newValue!;
                                                          producttypecontroller
                                                              .text = newValue;
                                                        });
                                                      },

                                                      // decoration: InputDecoration()
                                                      dropdownColor:
                                                          Color(0xfff7f7f7),
                                                    ),

                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          descriptioncontroller,
                                                      inputFormatters: const [],
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Description",
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          quantitycontroller,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: const [],
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: "Quantity",
                                                      ),

                                                      ///noted2
                                                      ///
                                                      ///
                                                      ///
                                                      /// divisionlislist.add(DivisionModel(
                                                      // name: state
                                                      //     .viewDivisionModel.data[i].divisionName,
                                                      // id: state.viewDivisionModel.data[i].id));
                                                    ),

                                                    // const SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    // TextFormField(
                                                    //   controller:
                                                    //       salepricecontroller,
                                                    //   autocorrect: true,
                                                    //  keyboardType:
                                                    //       TextInputType.number,
                                                    //   decoration:
                                                    //       const InputDecoration(
                                                    //     labelText: 'Sale Price',
                                                    //   ),
                                                    // ),
                                                    // const SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    // TextFormField(
                                                    //  keyboardType:
                                                    //       TextInputType.number,
                                                    //   autocorrect: true,

                                                    //   decoration:
                                                    //       const InputDecoration(
                                                    //     labelText: 'Price',
                                                    //   ),
                                                    // ),
                                                    // const SizedBox(
                                                    //   height: 10,
                                                    // ),
                                                    // TextFormField(
                                                    //   controller:
                                                    //       discountcontroller,
                                                    //   autocorrect: true,
                                                    // keyboardType:
                                                    //       TextInputType.number,
                                                    //   decoration:
                                                    //       const InputDecoration(
                                                    //     labelText: 'Discount',
                                                    //   ),
                                                    // ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          remarkcontroller,
                                                      autocorrect: true,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Remark',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ]),
                                              actions: [
                                                MaterialButton(
                                                  textColor: Colors.black,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'CANCEL',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  // child: const Text("SUBMIT",
                                                  //     style: TextStyle(
                                                  //         color: Colors.white,
                                                  //         fontSize: 12)),
                                                  onPressed: () {
                                                    if (namecontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Name");
                                                    } else if (descriptioncontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Description");
                                                    } else if (producttypecontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Product Type");
                                                    } else if (quantitycontroller
                                                        .text.isEmpty) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please Enter Quntity");
                                                    } else {
                                                      // Navigator.pop(context);

                                                      BlocProvider.of<
                                                                  GetViewAssetsBloc>(
                                                              context)
                                                          .add(ViewAssetEvent(
                                                        name:
                                                            namecontroller.text,
                                                        productType:
                                                            producttypecontroller
                                                                .text,
                                                        description:
                                                            descriptioncontroller
                                                                .text,
                                                        quantity:
                                                            quantitycontroller
                                                                .text,
                                                        salePrice:
                                                            salepricecontroller
                                                                .text,
                                                        price: pricecontroller
                                                            .text,
                                                        discount:
                                                            discountcontroller
                                                                .text,
                                                        remark: remarkcontroller
                                                            .text,
                                                      ));
                                                    }
                                                  },

                                                  child: BlocConsumer<
                                                          GetViewAssetsBloc,
                                                          ViewAssetsState>(
                                                      builder:
                                                          (context, state) {
                                                    // if (state is Checking) {
                                                    //   return CircularProgressIndicator(
                                                    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                                    //     strokeWidth: 2,
                                                    //   );
                                                    // }

                                                    if (state is Logginging) {
                                                      return const SizedBox(
                                                        height: 18.0,
                                                        width: 18.0,
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.black),
                                                          strokeWidth: 2,
                                                        ),
                                                      );
                                                    } else {
                                                      return const Text(
                                                          "SUBMIT",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12));
                                                    }
                                                  }, listener:
                                                          (context, state) {
                                                    if (state
                                                        is ViewAssetssuccess) {
                                                      Fluttertoast.showToast(
                                                          msg: "Asset Added",
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                      fetcher();
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        namecontroller.clear();
                                                        producttypecontroller
                                                            .clear();
                                                        descriptioncontroller
                                                            .clear();
                                                        quantitycontroller
                                                            .clear();
                                                        remarkcontroller
                                                            .clear();
                                                        salepricecontroller
                                                            .clear();
                                                        pricecontroller.clear();
                                                        remarkcontroller
                                                            .clear();
                                                      });
                                                      //  this.setState(() {
                                                      //                          firstName.clear();
                                                      //                           lastName.clear();
                                                      //                           gender.clear();
                                                      //                           modeOfDelivary.clear();
                                                      //                           address.clear();
                                                      //                           pincode.clear();
                                                      //                       }

                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(builder: (context) => const StaysHomePage()),
                                                      // );
                                                      // BlocProvider.of<
                                                      //             GetPendingOrderBloc>(
                                                      //         context)
                                                      // .add(
                                                      //     GetPendingOrderEvent());
                                                    }

                                                    //
                                                    //else if (state is ProfileViewError) {
                                                    //   Fluttertoast.showToast(
                                                    //       msg: "Rejection failed",
                                                    //       gravity: ToastGravity.CENTER,
                                                    //       textColor: Colors.white,
                                                    //       fontSize: 16.0);
                                                    // }
                                                  }),

                                                  color:
                                                      const Color(0xff59AF73),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  color: const Color(0xff59AF73),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(" Total Assets:"),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(state.viewAllAssetsModel.data.length
                                    .toString())
                              ]),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.viewAllAssetsModel.data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title: InkWell(
                                child: Column(children: [
                                  InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      namecontroller.text = state
                                                          .viewAllAssetsModel
                                                          .data[index]
                                                          .assetId
                                                          .name
                                                          .toString();
                                                      descriptioncontroller
                                                              .text =
                                                          state
                                                              .viewAllAssetsModel
                                                              .data[index]
                                                              .assetId
                                                              .description
                                                              .toString();
                                                    });

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return SingleChildScrollView(
                                                          child: SizedBox(
                                                            child: AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              title: const Text(
                                                                  'Edit Assets'),
                                                              content: Column(
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        TextFormField(
                                                                          //noted
                                                                          controller:
                                                                              namecontroller,
                                                                          autocorrect:
                                                                              true,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            labelText:
                                                                                'Asset Name',
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              descriptioncontroller,
                                                                          inputFormatters: const [],
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            labelText:
                                                                                "Description",
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ]),
                                                              actions: [
                                                                MaterialButton(
                                                                  textColor:
                                                                      Colors
                                                                          .black,
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      namecontroller
                                                                          .clear();

                                                                      descriptioncontroller
                                                                          .clear();
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'CANCEL',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                MaterialButton(
                                                                  // child: const Text("SUBMIT",
                                                                  //     style: TextStyle(
                                                                  //         color: Colors.white,
                                                                  //         fontSize: 12)),
                                                                  onPressed:
                                                                      () {
                                                                    if (namecontroller
                                                                        .text
                                                                        .isEmpty) {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "Please Enter Name");
                                                                    } else if (descriptioncontroller
                                                                        .text
                                                                        .isEmpty) {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                              msg: "Please Enter Description");
                                                                    } else {
                                                                      // Navigator.pop(context);

                                                                      // BlocProvider.of<GetAssetsEditDetailedsBloc>(context).add(AssetsEditDetailedEvent(
                                                                      //     name: namecontroller
                                                                      //         .text,
                                                                      //     description: descriptioncontroller
                                                                      //         .text,
                                                                      //     assetId: state
                                                                      //         .viewAllAssetsModel
                                                                      //         .data[index]
                                                                      //         .assetId
                                                                      //         .id));
                                                                    }
                                                                  },

                                                                  child: BlocConsumer<
                                                                          GetAssetsEditDetailedsBloc,
                                                                          AssetsEditDetailedsState>(
                                                                      builder:
                                                                          (context,
                                                                              state) {
                                                                    // if (state is Checking) {
                                                                    //   return CircularProgressIndicator(
                                                                    //     valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                                                                    //     strokeWidth: 2,
                                                                    //   );
                                                                    // }

                                                                    if (state
                                                                        is AssetsEditing) {
                                                                      return const SizedBox(
                                                                        height:
                                                                            18.0,
                                                                        width:
                                                                            18.0,
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          valueColor:
                                                                              AlwaysStoppedAnimation<Color>(Colors.black),
                                                                          strokeWidth:
                                                                              2,
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return const Text(
                                                                          "SUBMIT",
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12));
                                                                    }
                                                                  }, listener:
                                                                          (context,
                                                                              state) {
                                                                    if (state
                                                                        is AssetsEditDetailedssuccess) {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "Asset Updated",
                                                                          gravity: ToastGravity
                                                                              .CENTER,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0);
                                                                      fetcher();
                                                                      Navigator.pop(
                                                                          context);
                                                                      setState(
                                                                          () {
                                                                        namecontroller
                                                                            .clear();

                                                                        descriptioncontroller
                                                                            .clear();
                                                                      });
                                                                      //  this.setState(() {
                                                                      //                          firstName.clear();
                                                                      //                           lastName.clear();
                                                                      //                           gender.clear();
                                                                      //                           modeOfDelivary.clear();
                                                                      //                           address.clear();
                                                                      //                           pincode.clear();
                                                                      //                       }

                                                                      // Navigator.push(
                                                                      //   context,
                                                                      //   MaterialPageRoute(builder: (context) => const StaysHomePage()),
                                                                      // );
                                                                      // BlocProvider.of<
                                                                      //             GetPendingOrderBloc>(
                                                                      //         context)
                                                                      // .add(
                                                                      //     GetPendingOrderEvent());
                                                                    }

                                                                    //
                                                                    //else if (state is ProfileViewError) {
                                                                    //   Fluttertoast.showToast(
                                                                    //       msg: "Rejection failed",
                                                                    //       gravity: ToastGravity.CENTER,
                                                                    //       textColor: Colors.white,
                                                                    //       fontSize: 16.0);
                                                                    // }
                                                                  }),

                                                                  color: const Color(
                                                                      0xff59AF73),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Assets Name:",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    state
                                                        .viewAllAssetsModel
                                                        .data[index]
                                                        .assetId
                                                        .name
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Product Type :",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    state
                                                        .viewAllAssetsModel
                                                        .data[index]
                                                        .assetId
                                                        .productType
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Description:",
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    state
                                                        .viewAllAssetsModel
                                                        .data[index]
                                                        .assetId
                                                        .description
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Quantity:",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    state.viewAllAssetsModel
                                                        .data[index].quantity
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  )
                                                ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           AssetsDetailedView(
                                      //               assetId: state
                                      //                   .viewAllAssetsModel
                                      //                   .data[index]
                                      //                   .assetId
                                      //                   .id)

                                      //                   ),
                                      // );

                                      setState(() {});
                                    },
                                  ),

                                  //           Image.network(
                                  //   WebClient.imageUrl +
                                  //      state.viewEachReportModel
                                  //                 .records[index].photo[0]
                                  //                 ,
                                  //   width: 110,
                                  //   height: 180,
                                  // ),

                                  //  Image.network(
                                  //     WebClient.imageUrl +
                                  //      state.viewEachReportModel.records[index].photo.length.,
                                  //     width: 110,
                                  //     height: 180,
                                  //   ),
                                ]),
                              ));
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
                listener: (context, state) {}),
          ],
        ),
      ),
    );
  }

  Widget theDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: const BoxDecoration(
                color: Color(0xff59AF73),
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/wti_logo.png"),
                //   // fit: BoxFit.cover,
                // ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(
                      width: 120,
                      height: 80,
                      // child: CircleAvatar(
                      //   radius: 50.0,
                      //   backgroundImage: AssetImage(
                      //     "assets/images/wti_logo.png",
                      //   ),
                      //   backgroundColor: Colors.transparent,
                      // ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    // Text(
                    //   "Welcome to",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 18.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Text(
                    //   "Anti Snare Walk",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 20.0,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              )),
          Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  "Home",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfilePage()));
                },
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListTile(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const ParticipentsPage()));
                // },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "####",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ListTile(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const SignupSuccess()));
                // },
                leading: const Icon(Icons.add, color: Colors.white),
                title: const Text(
                  "####",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              ListTile(
                  // onTap: () {
                  //   Navigator.pop(context);
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const Completesnarereport()));
                  // },
                  leading: const Icon(Icons.all_inbox, color: Colors.white),
                  title: const Text(
                    "All Reports",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              /////very very important

              //    ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>  MyPendingdata()));
              // },
              // leading: const Icon(Icons.all_inbox, color: Colors.blueGrey),
              // title: const Text(
              //   "Local Data",
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, color: Colors.blueGrey),
              // )),
              // ListTile(
              // onTap: () {
              //   Navigator.pop(context);
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               const SnareDetailsOffline()));
              // },
              // leading: const Icon(Icons.data_array, color: Colors.blueGrey),
              // title: const Text("Report a Snare")),
              // ListTile(
              //     onTap: () {
              //       Navigator.pop(context);
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) =>
              //                   const ParticipentsOfflinePage()));
              //     },
              //     leading: const Icon(Icons.data_array, color: Colors.blueGrey),
              //     title: const Text("Pending List")),
              ListTile(
                onTap: () {
                  PrefManager.clearToken();

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                leading: const Icon(Icons.logout_outlined, color: Colors.white),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
