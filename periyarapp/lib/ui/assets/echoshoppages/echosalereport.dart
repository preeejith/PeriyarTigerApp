import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echosalereportbloc/echosalereportbloc.dart';
import 'package:parambikulam/bloc/assets/echoshop/echosalereportbloc/echosalereportevent.dart';
import 'package:parambikulam/bloc/assets/echoshop/echosalereportbloc/echosalereportstate.dart';

class EchoSaleReport extends StatefulWidget {
  const EchoSaleReport({Key? key}) : super(key: key);

  @override
  State<EchoSaleReport> createState() => _EchoSaleReportState();
}

class _EchoSaleReportState extends State<EchoSaleReport> {
  @override
  void initState() {
    fetcher();

    super.initState();
  }

  void fetcher() async {
    // token = await PrefManager.getToken();

    BlocProvider.of<GetEchoSaleReportBloc>(context).add(GetEchoSaleReportEvent(
      date: "2022-04-07T08:55:07.426Z",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sale Report"), actions: []),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey,
            ),
            BlocConsumer<GetEchoSaleReportBloc, EchoSaleReportState>(
                builder: (context, state) {
                  if (state is EchoSaleReportSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.echoSalesReportModel.data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  title: InkWell(
                                child: Column(children: [
                                  InkWell(
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    "Ticket Name:",
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    state.echoSalesReportModel
                                                        .data[index].ticketNo
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
                                                    state.echoSalesReportModel
                                                        .data[index].ticketNo
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
                                                    state.echoSalesReportModel
                                                        .data[index].ticketNo
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
                                                    state.echoSalesReportModel
                                                        .data[index].ticketNo
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
                                    onTap: () {},
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
}
