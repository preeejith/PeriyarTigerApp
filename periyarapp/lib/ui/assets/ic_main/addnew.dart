import 'package:flutter/material.dart';

import 'package:parambikulam/ui/assets/ic_main/addassetsmain.dart';
import 'package:parambikulam/ui/assets/ic_main/addproductmain.dart';

///////
class AddNewMasterPage extends StatefulWidget {
  const AddNewMasterPage({Key? key}) : super(key: key);

  @override
  State<AddNewMasterPage> createState() => _AddNewMasterPageState();
}

class _AddNewMasterPageState extends State<AddNewMasterPage> {

  String? index1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Add New"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(),
            SizedBox(
              height: 18,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 1.5,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Add Assets"),
                  color: Color(0xfff68D389),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddAssetsMain()));
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 1.5,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Add Product"),
                  color: Color(0xfff68D389),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProductMain()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
