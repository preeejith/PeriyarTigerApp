import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsbloc.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsevent.dart';
import 'package:parambikulam/bloc/assets/ic_viewunitsbloc/ic_viewunitsstate.dart';
import 'package:parambikulam/ui/assets/bottomnav.dart';
import 'package:parambikulam/ui/assets/homepages_assets/unitsview/unitdetailedview.dart';

////
class IcViewUnits extends StatefulWidget {
  const IcViewUnits({Key? key}) : super(key: key);

  @override
  _IcViewUnits createState() => _IcViewUnits();
}

///
class _IcViewUnits extends State<IcViewUnits> {
  String? token;
  @override
  void initState() {
    BlocProvider.of<GetIcViewUnitsBloc>(context).add(RefreshIcViewUnitsEvent());
    fetcher();

    super.initState();
  }

  void fetcher() async {
    BlocProvider.of<GetIcViewUnitsBloc>(context).add(FetchIcViewUnitsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1F1F1F),
      appBar: AppBar(
        title: const Text("Units"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomerBottomNavigation())),
        ),
      ),
      body: profileBody(),
    );
  }

/////
////////
  Widget profileBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocConsumer<GetIcViewUnitsBloc, IcViewUnitsState>(
                builder: (context, state) {
                  if (state is IcViewUnitsSuccess) {
                    return state.icViewUnitsModel.user!.length == 0
                        ? Center(child: Text("No units are available"))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.icViewUnitsModel.user!.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 6,
                                    ),
                                    InkWell(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xfff292929),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 4,
                                              blurRadius: 4,
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Unit Name : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.icViewUnitsModel
                                                          .user![index].name
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Unit Type : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state.icViewUnitsModel
                                                          .user![index].type
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        "Description : ",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    Text(
                                                      state
                                                          .icViewUnitsModel
                                                          .user![index]
                                                          .description
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                        ),
                                      ),
                                      onTap: () {
                                        //
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UnitsDetailedView(
                                                  busstatus: state
                                                              .icViewUnitsModel
                                                              .user![index]
                                                              .type
                                                              .toString() ==
                                                          "Transport Vehicle"
                                                      ? true
                                                      : false,
                                                  untitype: state
                                                      .icViewUnitsModel
                                                      .user![index]
                                                      .type
                                                      .toString(),
                                                  unitName: state
                                                      .icViewUnitsModel
                                                      .user![index]
                                                      .name
                                                      .toString(),
                                                  unitId: state.icViewUnitsModel
                                                      .user![index].id
                                                      .toString(),
                                                  index: index,
                                                  icViewUnitsModel:
                                                      state.icViewUnitsModel)),
                                        );

                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            });
                  } else {
                    return Center(
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
                },
                listener: (context, state) {}),
          ],
        ),
      ),
    );
  }
}
