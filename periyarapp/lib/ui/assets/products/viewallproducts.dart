import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:parambikulam/bloc/product/productbloc.dart';
import 'package:parambikulam/bloc/product/productevent.dart';
import 'package:parambikulam/bloc/product/productstate.dart';
import 'package:parambikulam/ui/assets/products/productdetailview.dart';

class MyProducts extends StatefulWidget {
  const MyProducts({Key? key}) : super(key: key);

  @override
  State<MyProducts> createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
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
    BlocProvider.of<ProductBloc>(context).add(GetProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text('My Products'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is GetProductSuccess) {
                    return Column(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              state.productListModel.productModel!.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: InkWell(
                              child: Column(children: [
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width * 2,
                                      // height: MediaQuery.of(context).size.height / 3.5,
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      6,
                                                  width: 100,
                                                  decoration: new BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/echobag.png"),
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        state
                                                            .productListModel
                                                            .productModel![
                                                                index]
                                                            .name
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        state
                                                            .productListModel
                                                            .productModel![
                                                                index]
                                                            .description
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    ///impotrtant
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailedView(
                                                productModel: state
                                                    .productListModel
                                                    .productModel![index],
                                              )),
                                    );

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

                                SizedBox(
                                  height: 8,
                                ),
                              ]),
                            ));
                          },
                        ),
                      ],
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
