import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parambikulam/bloc/assets/localbloc/ibprogramsofflinebloc.dart';
import 'package:parambikulam/ui/assets/local/offline_ui/ibmaindetailedview.dart';

class IBOfflineReport extends StatefulWidget {
  ///bloc//////
  final OfflineDataReceived2 state;
  const IBOfflineReport({Key? key, required this.state}) : super(key: key);

  @override
  State<IBOfflineReport> createState() => _IBOfflineReportState();
}

class _IBOfflineReportState extends State<IBOfflineReport> {
  @override
  Widget build(BuildContext context) {
    print(widget.state.items!.length);
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 3 / 2.5,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6),
        itemCount: widget.state.items!.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 200,
                decoration: widget.state.items![index]['coverImage'] != null
                    ? BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: FileImage(
                            File(
                              widget.state.items![index]['coverImage'],
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      )
                    : BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/elephant2.webp'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                child: ListTile(
                  subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  widget.state.items![index]['progName'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => IbMainDetailed(
                          index: index.toString(),
                          state: widget.state,
                        )),
              );
            },
          );
        });
  }
}
