import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:parambikulam/local/db/dbhelper.dart';

class TodaysSale extends StatefulWidget {
  const TodaysSale({Key? key}) : super(key: key);

  @override
  State<TodaysSale> createState() => _TodaysSaleState();
}

class _TodaysSaleState extends State<TodaysSale> {
  List uploadData = [];
  void initState() {
    fetcher();
    super.initState();
  }

  void fetcher() async {
    DatabaseHelper db = DatabaseHelper.instance;
    var data = await db.getPlaceorderData();
    for (int i = 0; i < data.length; i++) {
      uploadData.add(jsonDecode(data[i]['data']));

      setState(() {});
    }
    print(uploadData);
  }

  @override
  Widget build(BuildContext context) {
    return uploadData.length == 0
        ? Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text('Pending Sales'),
              ),
              actions: [],
            ),
            body: Center(
              child: Text("No Items left to upload"),
            ),
          )
        : Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text('Pending Sales'),
              ),
              actions: [],
            ),
            body: 
            ListView.builder(
              shrinkWrap: true,
              itemCount: uploadData.length,
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
                                  itemCount: uploadData[index]['items'].length,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return ListTile(
                                      title: Text(uploadData[index]['items']
                                          [index1]['productName']),
                                      subtitle: Text(
                                          "${uploadData[index]['items'][index1]['quantity']} X ${uploadData[index]['items'][index1]['totalamount']}"),
                                      trailing: Text(
                                          "Rs. ${uploadData[index]['items'][index1]['quantity'] * uploadData[index]['items'][index1]['totalamount']}"),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text("Employee Discount"),
                          trailing: uploadData[index]['isEmployee']
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
                                          ' Rs. ${calculateTotal(uploadData[index]['items'], uploadData[index]['isEmployee'])} ',
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

  calculateTotal(cartData, bool isEmployee) {
    double totalAmount = 0;
    for (int i = 0; i < cartData!.length; i++) {
      totalAmount = totalAmount +
          double.parse(cartData![i]['quantity'].toString()) *
              double.parse(cartData![i]['totalamount'].toString());
    }
    return isEmployee ? (totalAmount - totalAmount * .1) : totalAmount;
  }
}
