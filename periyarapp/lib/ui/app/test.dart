import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TestScreen extends StatefulWidget {
  _TestScreen createState() => _TestScreen();
}

class _TestScreen extends State<TestScreen> {
  double? percent = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Screen"),
      ),
      body: mainBody(),
    );
  }

  Widget mainBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return CircularPercentIndicator(
                        radius: 60,
                        percent: percent!,
                      );
                    });
                for (int i = 0; i <= 100; i++) {
                  await Future.delayed(Duration(seconds: 1));
                  percent = (((i / 100) * 100) / 100);
                  print(percent.toString());
                  setState(() {});
                }
              },
              icon: Icon(Icons.add)),
          SizedBox(
            height: 20,
          ),
          // Center(
          //   child:
          // )
        ],
      ),
    );
  }
}
