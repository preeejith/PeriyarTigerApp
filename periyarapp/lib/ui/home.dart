import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:parambikulam/config.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var tabStatus = 'Programs';

  // @override
  // void initState() {
  //   super.initState();
  //   BlocProvider.of<DataBloc>(context).add(LoadData());
  // }

  final List newList = [
    {
      'img': 'assets/bgptrr.png',
      't1': 'Mark Todays\nAttendence',
      't2': 'Todays Marked',
      'onclick': '/markAttendance',
      'boxColor': HexColor("#FFFFFF"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1': 'Student List',
      't2': 'View Student List & Profile',
      'onclick': '/studentsList',
      'boxColor': HexColor("#9B8DFD"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1': 'Add Topper\nVideo',
      't2': '3 Latest Video',
      'onclick': '/topperVideo',
      'boxColor': HexColor("#CC3E3E"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1': 'Add marks',
      't2': '31 latest Videos',
      'onclick': '/addMark',
      'boxColor': HexColor("#FFFFFF"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1': 'Class Broascast',
      't2': 'Send message to\nStudent & Parents',
      'onclick': '/createBrodCast',
      'boxColor': HexColor("#FFFFFF"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1': 'Chat with Parents',
      't2': '41 unread  messages',
      'boxColor': HexColor("#FFFFFF"),
    },
  ];

  final List bookingList = [
    {
      'img': 'assets/bgptrr.png',
      't1':
          'Combo Package (Safari, Trekking, Rafting etc & including food) Jungle Safari',
      't2': 'Todays Marked',
      'onclick': '/markAttendance',
      'boxColor': HexColor("#FFFFFF"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1':
          'Combo Package (Safari, Trekking, Rafting etc & including food) Jungle Safari',
      't2': 'View Student List & Profile',
      'onclick': '/studentsList',
      'boxColor': HexColor("#9B8DFD"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1':
          'Combo Package (Safari, Trekking, Rafting etc & including food) Jungle Safari',
      't2': '3 Latest Video',
      'onclick': '/topperVideo',
      'boxColor': HexColor("#CC3E3E"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1':
          'Combo Package (Safari, Trekking, Rafting etc & including food) Jungle Safari',
      't2': '31 latest Videos',
      'onclick': '/addMark',
      'boxColor': HexColor("#FFFFFF"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1':
          'Combo Package (Safari, Trekking, Rafting etc & including food) Jungle Safari',
      't2': 'Send message to\nStudent & Parents',
      'onclick': '/createBrodCast',
      'boxColor': HexColor("#FFFFFF"),
    },
    {
      'img': 'assets/bgptrr.png',
      't1':
          'Combo Package (Safari, Trekking, Rafting etc & including food) Jungle Safari',
      't2': '41 unread  messages',
      'boxColor': HexColor("#FFFFFF"),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('Home'.trim(), style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(
            Icons.grid_view,
            color: Colors.black,
          ),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image(
              image: AssetImage('assets/icons/cart_icon.png'),
              fit: BoxFit.contain,
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: AppColors.appColor,
              backgroundImage: AssetImage('assets/icons/profile_pic.png'),
              radius: 20.0,
            ),
          )
        ],
      ),
      // drawer: NavDrawer(),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tabStatus = 'Programs';
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Programs'.trim(),
                          style: TextStyle(
                              fontWeight: tabStatus == 'Programs'
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                      SizedBox(height: 4),
                      Container(
                        height: 3,
                        width: 60,
                        color: tabStatus == 'Programs'
                            ? AppColors.appColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    setState(() {
                      tabStatus = 'Booking';
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Booking'.trim(),
                        style: TextStyle(
                            fontWeight: tabStatus == 'Booking'
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 3,
                        width: 60,
                        color: tabStatus == 'Booking'
                            ? AppColors.appColor
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: new InputDecoration(
                  labelText: "Search",
                  labelStyle: TextStyle(color: AppColors.appColor),
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: AppColors.appColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _gridView(context),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [Text('Previous Booking'), Spacer(), Text('View All')],
            ),
            SizedBox(
              height: 10,
            ),
            _listView(context)
          ],
        ),
      )),
    );
  }

  Widget _gridView(
    BuildContext context,
  ) {
    double itemHeight = 300;
    double itemWidth = MediaQuery.of(context).size.width / 2.5;
    return new GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: newList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: (itemWidth / itemHeight) / 0.9),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // switch(newList[index]['onclick']){
            //   case "/markAttendance" :
            //     if(userProfileModel.teacher.allottedClass == null){}
            //      // AppWidgets.showToast(msg: "No class found");
            //     else if(currentClassId != userProfileModel.teacher.allottedClass.sId){}
            //      // AppWidgets.showToast(msg: "You are not able to mark attendance of this class");
            //     else if(teacherViewATModel.status && currentClassId == userProfileModel.teacher.allottedClass.sId){}
            //       // Navigator.push(context,MaterialPageRoute(
            //       //     builder: (context) => AttendanceReport(classId: currentClassId, navigation: "atHome",)));
            //     else{}
            //       // Navigator.pushNamed(context, newList[index]['onclick'], arguments: ScreenArguments(currentClassId,
            //       //   userProfileModel.teacher.allottedClass.className, "mark"));
            //     break;

            //   case "/studentsList":
            //     if(userProfileModel.teacher.allottedClass == null){}
            //      // AppWidgets.showToast(msg: "Sorry! you are not assigned to classes");
            //     else
            //     Navigator.pushNamed(context, newList[index]['onclick'], arguments:  currentClassId);
            //     break;
            //   case "/addMark":
            //     if(userProfileModel.teacher.allottedClass == null){}
            //      // AppWidgets.showToast(msg: "Sorry! you are not assigned to classes");
            //     else
            //       Navigator.pushNamed(context, newList[index]['onclick']);
            //     break;
            //   default:
            //     Navigator.pushNamed(context, newList[index]['onclick']);
            //     break;

            // }
          },
          child: Container(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 0,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: new Image(
                      image: AssetImage(newList[index]['img']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  flex: 0,
                  child: new Text(
                    newList[index]['t1'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: new Text(newList[index]['t2']),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listView(
    BuildContext context,
  ) {
    return new ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: bookingList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            // switch(newList[index]['onclick']){
            //   case "/markAttendance" :
            //     if(userProfileModel.teacher.allottedClass == null){}
            //      // AppWidgets.showToast(msg: "No class found");
            //     else if(currentClassId != userProfileModel.teacher.allottedClass.sId){}
            //      // AppWidgets.showToast(msg: "You are not able to mark attendance of this class");
            //     else if(teacherViewATModel.status && currentClassId == userProfileModel.teacher.allottedClass.sId){}
            //       // Navigator.push(context,MaterialPageRoute(
            //       //     builder: (context) => AttendanceReport(classId: currentClassId, navigation: "atHome",)));
            //     else{}
            //       // Navigator.pushNamed(context, newList[index]['onclick'], arguments: ScreenArguments(currentClassId,
            //       //   userProfileModel.teacher.allottedClass.className, "mark"));
            //     break;

            //   case "/studentsList":
            //     if(userProfileModel.teacher.allottedClass == null){}
            //      // AppWidgets.showToast(msg: "Sorry! you are not assigned to classes");
            //     else
            //     Navigator.pushNamed(context, newList[index]['onclick'], arguments:  currentClassId);
            //     break;
            //   case "/addMark":
            //     if(userProfileModel.teacher.allottedClass == null){}
            //      // AppWidgets.showToast(msg: "Sorry! you are not assigned to classes");
            //     else
            //       Navigator.pushNamed(context, newList[index]['onclick']);
            //     break;
            //   default:
            //     Navigator.pushNamed(context, newList[index]['onclick']);
            //     break;

            // }
          },
          child: Container(
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: new Image(
                          image: AssetImage(bookingList[index]['img']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 0,
                          child: new Text(
                            bookingList[index]['t2'],
                            maxLines: 3,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: new Text(bookingList[index]['t2']),
                            ),
                            Expanded(
                              flex: 0,
                              child: new Text(bookingList[index]['t2']),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: new Text(bookingList[index]['t2']),
                            ),
                            Expanded(
                              flex: 0,
                              child: new Text(bookingList[index]['t2']),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
