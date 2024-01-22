import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/bloc/syncoffline/blocsyncoffline.dart';
import 'package:parambikulam/bloc/syncoffline/eventsyncoffline.dart';
import 'package:parambikulam/bloc/syncoffline/statesyncoffline.dart';
import 'package:parambikulam/config.dart';
import 'package:parambikulam/ui/app/datasync/notuploaddetails.dart';
import 'package:parambikulam/ui/app/widgets/app_card.dart';

class NotUploadedList extends StatefulWidget {
  final List? finalList;
  NotUploadedList({this.finalList});
  _NotUploadedList createState() => _NotUploadedList();
}

class _NotUploadedList extends State<NotUploadedList> {
  @override
  void initState() {
    BlocProvider.of<BlocSyncOffline>(context)
        .add(GetFailedData(finalList: widget.finalList));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Upload failed"),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<BlocSyncOffline>().add(
                        UploadFailedData(
                          finalList: widget.finalList,
                        ),
                      );
                },
                icon: Icon(Icons.upload)),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: InkWell(
                  onTap: () async {},
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage(
                      "assets/bgptrr.png",
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<BlocSyncOffline, StateSyncOffline>(
          builder: (context, state) {
            if (state is ShowFailedData) {
              return Padding(
                padding: EdgeInsets.all(12.0),
                child: listContent(context, state),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
          listener: (context, state) {},
        ));
  }

  listContent(BuildContext context, ShowFailedData state) {
    return ListView.separated(
      itemCount: state.finalList!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoUploadDetails(
                  title: state.finalList![index]['title'],
                  id: state.finalList![index]['id'],
                  finalList: state.finalList,
                  index: index,
                ),
              ),
            );
          },
          child: AppCard(
            outLineColor: HexColor('#ff6e4a'),
            color: HexColor('#292929'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Programme Name",
                  style: StyleElements.bookingDetailsTitle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(state.finalList![index]['title']),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Failed Due To",
                  style: StyleElements.bookingDetailsTitle,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(state.finalList![index]['reason']),
                SizedBox(
                  height: 15.0,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "View More",
                      style:
                          TextStyle(color: HexColor("#838383"), fontSize: 12.0),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new Icon(
                      Icons.arrow_right_alt_outlined,
                      color: HexColor("#838383"),
                      size: 15.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
