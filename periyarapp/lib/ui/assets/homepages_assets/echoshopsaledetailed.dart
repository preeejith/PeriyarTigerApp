import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parambikulam/local/db/dbhelper.dart';

class SalesDetailed extends StatefulWidget {
  final String? isemployee, totalamount;

  final salesid;
  const SalesDetailed(
      {Key? key, this.salesid, this.isemployee, this.totalamount})
      : super(key: key);

  @override
  State<SalesDetailed> createState() => _SalesDetailedState();
}

class _SalesDetailedState extends State<SalesDetailed> {
  List<Map> salesdetailedlist = [];
  final totalamountcontroller = TextEditingController();
  int? totalamunt = 0;
  num? totalamunt2 = 0;
  DatabaseHelper? db = DatabaseHelper.instance;
  @override
  void initState() {
    fetcher();
    db!.getEchoSalesReportDetailfulldata();
    // BlocProvider.of<GetViewProfileBloc>(context)
    //     .add(GetSalesDetailedEvent(salesid: widget.salesid));
    super.initState();
  }

  fetcher() async {
    salesdetailedlist =
        await db!.getEchoSalesReportDetailedData(widget.salesid.toString());
    log(salesdetailedlist.length);
    // print(salesdetailedlist.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detailed Report"), actions: []),
      body: salesdetailedlist.isEmpty
          ? Center(child: CircularProgressIndicator())
          // Text(salesdetailedlist[0]['stockId'])
          : ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff292929),
                      borderRadius: BorderRadius.circular(8),
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: salesdetailedlist.length,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    totalamunt = int.parse(
                                        salesdetailedlist[index1]['quantity']);
                                    totalamunt2 = num.parse(
                                        salesdetailedlist[index1]
                                            ['salesPrice']);
                                    totalamountcontroller.text =
                                        (totalamunt2! * totalamunt!).toString();
                                    return ListTile(
                                      title: Text(salesdetailedlist[index1]
                                              ['itemName']
                                          .toString()),
                                      subtitle: Text(
                                          "${salesdetailedlist[index1]['quantity']} X ${salesdetailedlist[index1]['salesPrice']}"),
                                      trailing: Text(
                                          "Rs.            ${totalamountcontroller.text.toString()}"),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text("Employee Discount"),
                          trailing: widget.isemployee == "true"
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Item Total',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          ' Rs. ${widget.totalamount} ',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                          ),
                                        )
                                      ]),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
