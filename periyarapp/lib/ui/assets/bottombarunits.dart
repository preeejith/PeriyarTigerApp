import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:parambikulam/ui/assets/echoshoppages/new/myrequestview.dart';

import 'package:parambikulam/ui/assets/homepages_assets/productionunit_homepage.dart';

import 'package:parambikulam/ui/assets/sendrequest/sendrequestpage.dart';

DateTime? currentBackPressedTime;

class UnitsAssetsBottomNavigation extends StatefulWidget {
  UnitsAssetsBottomNavigation({Key? key}) : super(key: key);
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<UnitsAssetsBottomNavigation> {
  bool fcmInitCheck = true;

  int _selectedIndex = 0;

  List<Widget> _children = <Widget>[];

  String? fcmToken;

  @override
  void initState() {
    _children = [
      ProductionUnitHomePage(),
      SendRequestMasterPage(
        homenav: 'productionunit',
      ),
      MyRequestView(),
    ];

    super.initState();
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
                      color: Color(0xff59AF73),
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
                  label: 'Request',
                ),
                BottomNavigationBarItem(
                  activeIcon:
                      new Icon(Icons.request_page, color: Color(0xfff68D389)),
                  icon: new Icon(Icons.request_page),
                  label: 'My Request',
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
