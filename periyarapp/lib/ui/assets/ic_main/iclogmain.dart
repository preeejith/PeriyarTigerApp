import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainbloc.dart';
import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainevent.dart';

import 'package:parambikulam/bloc/assets/icbloc/iclogmainbloc/iclogmainstate.dart';

import 'package:parambikulam/ui/assets/homepages_assets/unitsview/assetsview_transfer.dart';
import 'package:parambikulam/ui/assets/local/function/ibmain_function.dart';

/////////
class IcLogmain extends StatefulWidget {
  const IcLogmain({
    Key? key,
  }) : super(key: key);

  @override
  State<IcLogmain> createState() => _IcLogmainState();
}

class _IcLogmainState extends State<IcLogmain> {
  int page = 1, totalpages = 1;
  bool stopListening = true;
  List<TransferAssetsModel> transferassetslislist = [];

  @override
  void initState() {
    BlocProvider.of<GetIcLogmainBloc>(context).add(RefreshIcLogmain());
    fetcher();

    super.initState();
  }

  void fetcher() async {
    transferassetslislist.clear();
    BlocProvider.of<GetIcLogmainBloc>(context).add(FetchIcLogmain());
    setState(() {});
  }

  var d1 = DateFormat('dd-MMM-yyyy');
  var d2 = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('IC Log'),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<GetIcLogmainBloc, IcLogmainState>(
          builder: (context, state) {
            if (state is IcLogmainsuccess) {
              if (transferassetslislist.isNotEmpty) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: transferassetslislist.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: InkWell(
                      child: Column(children: [
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Asset Name",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // state.icLogModel.data![index].assetId ==
                                        //         null
                                        //     ? Container()
                                        //     :

                                        Text(
                                          transferassetslislist[index]
                                              .assetName
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Quantity",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          transferassetslislist[index]
                                              .quantity
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "In Charge",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          transferassetslislist[index]
                                              .employeename
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Transfered To ",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          transferassetslislist[index]
                                              .unitName
                                              .toString(),
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Issued Date",
                                            style: TextStyle(fontSize: 12)),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          d1.format(DateTime.parse(convert(
                                                  transferassetslislist[index]
                                                      .date
                                                      .toString()))) +
                                              " | " +
                                              d2.format(DateTime.parse(convert(
                                                  transferassetslislist[index]
                                                      .date
                                                      .toString()))),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        )
                                      ]),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ]),
                    ));
                  },
                );
              } else {
                return Center(
                  child: SizedBox(
                    height: 28.0,
                    width: 28.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 2,
                    ),
                  ),
                );
              }

              // BlocListener<GetIcLogmainBloc, IcLogmainState>(
              //     listener: (context, addstate) {
              //       if (addstate is AddLogs) {
              //         state.icLogModel.data!.addAll(addstate.icLogModel.data!);

              //         page = page + 1;
              //         setState(() {});
              //       }
              //     },
              //     child: _icLog(context, state));
            } else {
              return Center(
                child: SizedBox(
                  height: 28.0,
                  width: 28.0,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
                ),
              );
            }
          },
          listener: (context, state) async {
            if (state is IcLogmainsuccess) {
              //////
              List items35 = await getAlltransferlogdata();
              // print(items35);
              if (items35.isNotEmpty) {
                for (int k = items35.length - 1;
                    k != items35.length - items35.length - 1;
                    --k) {
                  print("fv");
                  transferassetslislist.add(TransferAssetsModel(
                      assetId: "121212",
                      quantity: items35[k]['quantity'].toString(),
                      remark: "gtv",
                      assetName: items35[k]['assetname'].toString(),
                      unitName: items35[k]['unitname'].toString(),
                      employeename: items35[k]['employeename'].toString(),
                      date: items35[k]['date'].toString()));
                }
              }
              setState(() {});
              // for (int j = 0; j < state.icLogModel.data!.length; j++) {
              //   transferassetslislist.add(TransferAssetsModel(
              //       assetId: "121212",
              //       quantity: state.icLogModel.data![j].stock.toString(),
              //       remark: "gtv",
              //       assetName: state.icLogModel.data![j].assetId != null
              //           ? state.icLogModel.data![j].assetId!.name.toString()
              //           : "hello",
              //       unitName: state.icLogModel.data![j].toinventoryId!.name
              //           .toString(),
              //       date: state.icLogModel.data![j].createDate.toString()));
              // }
              setState(() {});
            }
          },
        ),
      ),
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

class ItemtocartModel {
  String? name;
  String? type;
  String? id;
  int? quantity;
  int? salesPrice;
  int? totalamount;
  ItemtocartModel({
    this.name,
    this.type,
    this.id,
    this.quantity,
    this.salesPrice,
    this.totalamount,
  });
}
