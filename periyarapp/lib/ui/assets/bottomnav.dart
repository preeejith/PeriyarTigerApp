/////////asssethome//////
///////////////////
/////////////

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:parambikulam/ui/assets/assetshomepage.dart';
import 'package:parambikulam/ui/assets/ic_main/addnew.dart';
import 'package:parambikulam/ui/assets/products/viewallproductmain.dart';

DateTime? currentBackPressedTime;

class CustomerBottomNavigation extends StatefulWidget {
  CustomerBottomNavigation({Key? key}) : super(key: key);
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<CustomerBottomNavigation> {
  bool fcmInitCheck = true;

  int _selectedIndex = 0;

  List<Widget> _children = <Widget>[];

  String? fcmToken;

  @override
  void initState() {
    super.initState();
    _children = [
      AssestsHomePage(),
      AddNewMasterPage(),
      ViewProductMain(),
      // MyProducts(),
    ];
  }

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_selectedIndex != 2) {
      setState(() {
        _selectedIndex = 2;
      });
    } else if (currentBackPressedTime == null ||
        now.difference(currentBackPressedTime!) > Duration(seconds: 2)) {
      currentBackPressedTime = now;
      Fluttertoast.showToast(
          msg: "Press again to exit the app",
          backgroundColor: Colors.black,
          gravity: ToastGravity.BOTTOM);
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return false;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          // body: IndexedStack(index: _selectedIndex, children: _children),
          body: _children[_selectedIndex],
          bottomNavigationBar: new Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Colors.black,
              textTheme: Theme.of(context).textTheme.copyWith(
                    caption: new TextStyle(
                      color: Color(0xfff68D389),
                    ),
                  ),
            ),
            child: BottomNavigationBar(
              onTap: onTabTapped,
              currentIndex: _selectedIndex,
              items: [
                BottomNavigationBarItem(
                  activeIcon: new Icon(Icons.shopping_basket,
                      color: Color(0xfff68D389)),
                  icon: new Icon(Icons.shopping_basket_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: new Icon(Icons.add, color: Color(0xfff68D389)),
                  icon: new Icon(Icons.add),
                  label: 'Add New',
                ),
                BottomNavigationBarItem(
                  activeIcon: new Icon(
                      Icons.production_quantity_limits_outlined,
                      color: Color(0xfff68D389)),
                  icon: new Icon(Icons.production_quantity_limits_outlined),
                  label: 'Product',
                ),
              ],
              selectedLabelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xfff68D389)),
              unselectedIconTheme: IconThemeData(
                color: Colors.grey,
              ),
              unselectedLabelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
