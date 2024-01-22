import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
////
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsbloc.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsevent.dart';
import 'package:parambikulam/bloc/assets/viewallassets/viewallassetsstate.dart';

import 'package:parambikulam/data/models/assetsmodel/viewallassetsmodel.dart';

import 'package:parambikulam/ui/assets/assetsdetailedview.dart';
import 'package:parambikulam/ui/assets/assetshomepage.dart';

class AssetViewPage extends StatefulWidget {
  final String unit;
  const AssetViewPage({Key? key, required this.unit}) : super(key: key);

  @override
  State<AssetViewPage> createState() => _AssetViewPageState();
}

class _AssetViewPageState extends State<AssetViewPage> {
  List<ViewAssetsModel> viewassetslist = [];

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController producttypecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final TextEditingController salepricecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
  final TextEditingController discountcontroller = TextEditingController();
  final TextEditingController remarkcontroller = TextEditingController();
  ViewAllAssetsModel? viewAllAssetsModel;

  void initState() {
    super.initState();

    BlocProvider.of<GetViewallAssetsBloc>(context).add(FetchAssetsdataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ASSETS"), actions: []),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<GetViewallAssetsBloc, ViewallAssetsState>(
                  builder: (context, state) {
                if (state is FetchAssetsSuccess) {
                  // viewAllAssetsModel = state.viewAllAssetsModel;
                  return ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: state.viewassetsModel.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return state.viewassetsModel.length == 0
                          ? Center(
                              child: Text(
                              "No Assets Available",
                              style: TextStyle(color: Colors.white),
                            ))
                          : state.viewassetsModel[index].assetidtaken
                                      .toString() ==
                                  "true"
                              ? SizedBox()
                              : ListTile(
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
                                          // height: MediaQuery.of(context).size.height / 3.5,
                                          decoration: BoxDecoration(
                                            color: Color(0xfff292929),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    state.viewassetsModel[index]
                                                                .quantity
                                                                .toString() !=
                                                            "0"
                                                        ? Colors.grey
                                                            .withOpacity(0.3)
                                                        : Colors.redAccent
                                                            .withOpacity(0.3),
                                                spreadRadius: 4,
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color: Colors.white,
                                                      height: 85,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                      child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              6,
                                                          child: Icon(
                                                            Icons
                                                                .shopping_basket,
                                                            color: Colors.black,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              16,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Asset Name:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewassetsModel[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(
                                                                "Quantity:",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Text(
                                                                state
                                                                    .viewassetsModel[
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12),
                                                              )
                                                            ]),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        state
                                                                    .assetMasterTable[
                                                                        index]
                                                                    .description
                                                                    .toString() ==
                                                                ""
                                                            ? SizedBox()
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                    const Text(
                                                                        "Description:",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12)),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      state
                                                                          .assetMasterTable[
                                                                              index]
                                                                          .description
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  ]),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AssetsDetailedView(
                                                      unit: widget.unit,
                                                      viewassetslist:
                                                          viewassetslist,
                                                      assetId: state
                                                          .viewassetsModel[
                                                              index]
                                                          .assetid
                                                          .toString(),
                                                      viewassetsModel:
                                                          state.viewassetsModel,
                                                      assetMasterTable: state
                                                          .assetMasterTable,
                                                      index: index)),
                                        );

                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ]),
                                ));
                    },
                  );
                } else {
                  return viewAllAssetsModel.toString() == null.toString()
                      ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.not_interested,
                                size: 50,
                              ),
                            ],
                          ),
                        )
                      : Center(
                          child: SizedBox(
                            height: 28.0,
                            width: 28.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                              strokeWidth: 2,
                            ),
                          ),
                        );
                }
              }, listener: (context, state) async {
                if (state is ViewallAssetsSuccess) {
                  /////removing unnessasary list//
//                   viewassetslist.clear();

//                   DatabaseHelper? db = DatabaseHelper.instance;

//                   List items21 = [];
//                   items21 = await db.getICAddAssetsListDownloadData();

//                   if (items21.isNotEmpty) {
//                     for (int j = items21.length - 1;
//                         j != items21.length - items21.length - 1;
//                         --j) {
//                       var data = jsonDecode(items21[j]['data']);

//                       viewassetslist.add(ViewAssetsModel(
//                         assetname: data['assets'][0]['name'],
//                         quantity: data['assets'][0]['quantity'],
//                         date: state.viewAllAssetsModel.data[0].createDate
//                             .toString(),
//                         description: data['assets'][0]['description'],
//                         assetid: "123123",
//                         producttype: data['assets'][0]['productType'],
//                       ));
//                     }
//                   }
// //////
//                   ///
//                   ///
//                   ///
//                   /////////////////////////////////old
//                   ///

//                   for (int i = 0; i < viewAllAssetsModel!.data.length; i++) {
//                     viewassetslist.add(ViewAssetsModel(
//                       assetname: state.viewAllAssetsModel.data[i].assetId.name
//                           .toString(),
//                       quantity:
//                           state.viewAllAssetsModel.data[i].quantity.toString(),
//                       description: state
//                           .viewAllAssetsModel.data[i].assetId.description
//                           .toString(),
//                       date: state.viewAllAssetsModel.data[i].createDate
//                           .toString(),
//                       assetid: state.viewAllAssetsModel.data[i].assetId.id
//                           .toString(),
//                       producttype: state
//                           .viewAllAssetsModel.data[i].assetId.productType
//                           .toString(),
//                     ));
//                   }

//                   setState(() {});
                }
              }),
            ],
          ),
        ));
  }
}
