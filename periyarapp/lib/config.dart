import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Config {
  static const String APP_TITLE = "KHPT - Breaking the Barrier";
  static const String APP_KEY = "4D18E8E4-1521-4C11-A980-5B2EBAFB24EA";
  static const String SENTRY_DSN =
      'https://98d8e08c663d47a4bc2e5113967d0ac7@o269165.ingest.sentry.io/5660074';
  static const String PLATFORM = "Mobile";
  static const String DB = "symmetry_btb_app.db";
  static const String SQLITE_DB = "btb.db";
  static const String SQLITERT_DB = "btb_rt.db";

  static const bool FORCE_RELOAD = false;
}

String kDefaultLocale = "en";

const String kAppVersion = '1.0.1';
const int kMinMajorAppVersion = 1;
const int kMinMinorAppVersion = 0;
const int kMinPatchAppVersion = 1;

/* Shared preferences keys */
const String kSharedPrefLoginID = "login_id";
const String kSharedPrefAuthKey = "auth_key";
const String kSharedPrefAppVersion = "app_version";
const String kSharedPrefDomain = "domain";

const String kKeychainToken = 'api_token';
const String kKeychainLoginID = 'login_id';
const String kKeychainDomain = 'domain';
const String kKeychainSecret = 'secret';

const int kMaxRecordsPerApiPage = 5000;
const int kMillisecondsToRefreshData = 1000 * 60 * 15; // 15 minutes
const int kMillisecondsToRefreshActivities = 1000 * 60 * 60 * 24; // 1 day
const int kUpdatedAtBufferSeconds = 600;

class AppColors {
  // Map<int, Color> color = {
  //   50: Color.fromRGBO(83, 168, 116, .1),
  //   100: Color.fromRGBO(83, 168, 116, .2),
  //   200: Color.fromRGBO(83, 168, 116, .3),
  //   300: Color.fromRGBO(83, 168, 116, .4),
  //   400: Color.fromRGBO(83, 168, 116, .5),
  //   500: Color.fromRGBO(83, 168, 116, .6),
  //   600: Color.fromRGBO(83, 168, 116, .7),
  //   700: Color.fromRGBO(83, 168, 116, .8),
  //   800: Color.fromRGBO(83, 168, 116, .9),
  //   900: Color.fromRGBO(83, 168, 116, 1),
  // };
  
  // MaterialColor primeSwatchColor = MaterialColor(0xFF2BA15A, color);
  static Color appColor = HexColor("#53A874");
  static Color appColor1 = HexColor("#FFFFFF"); //Color(0xFFD8D8D8);
  // static Color appColor2 = Color(0xFF2BA15A);
  // static Color appColor3 = Color(0xFF32AA63);
  // static Color appColor4 = Color(0xFF2BA15A);
  // static Color appColor5 = Color(0xFF32AA63);
  // static Color gold = Color(0xFFB58759);
  // static Color accent = Color(0xFF279554);

  static Color white = Colors.white;
  static Color black = Colors.black87;
  static Color label = Color(0xFFBCBCBC);
  // static Color subtextHead = Color(0xFF676767);
  // static Color subTextColor = Color(0xFFC3C3C3);

  // static Color textColor = Colors.black; //Color(0xFFD8D8D8);
  //Color(0xFFD8D8D8);
  // static Color gray60a = Colors
  //     .black54; //Color(0x99D8D8D8);// labels in form, does not include menu and button texts.
  // static Color gray25a = Colors.black26; //Color(0x40D8D8D8);
  // static Color pageBg = Color(0xFFF4F0F1); // Colors.white;//Color(0xFF33333D);
  // static Color inputBg = Color(0xFF26282F);

  // static Color blueAccent = Color(0xFF5DADE2);
  // static Color actionButton = Color(0xFFFFBB22);
  // static Color iconTextColor = Colors.white;

  // static Color textFieldColor = Color(0xFFFAFAFA);
  // static Color formBg = Color(0xFFFAFAFA);

  // static Color cardBg = Colors.white; //Color(0xFF33333D);
  // static Color dividerColor = Color(0xFF0082FB);

  // static Color accent = Color(0xFFB2F2FF);
  // static Color errorColor = Color(0xFFFF6951);
  // static Color? dangerColor = Colors.red[700];

  // static Color focusedInputColor = Color(0xFF0082FB);
  // static Color inputBorderColor = Color(0xFFF8F9F9);
  // static Color bottomBarColor = Color(0xFFF8F9F9);
  // static Color? highLightColor = Colors.blue[300]; // Color(0xFF0082FB);

  // static Color iconColor = Colors.black;
  // static Color iconDirtyColor = Colors.red;
  // static Color successColor =
  //     Colors.blue; //used in collection_view posted status
  // static Color circularProgress = Colors.black;
  // static Color slideEdit = Colors.orange;
  // static Color slideDelete = Colors.red;
  // static Color slideforeground = Colors.white;

  // static Color? floatingBackground = Colors.blue[800];
  // static Color floatingIconText = Colors.white;

  // static Color infoBarColor = Color(0xFFFFBB22);
  // static Color infoBarTextColor = Colors.black;

  // static Color infoColor = Colors.black;
}

const List<String> kLanguages = ['en', 'en_IN', 'hi', 'hi_IN'];

class StyleElements {
  static TextStyle packageRateSub = new TextStyle(
      color: HexColor("#BEBEBE"), fontSize: 14.0, fontWeight: FontWeight.w400);
  static TextStyle packageRateSubText = new TextStyle(
      color: HexColor("#BEBEBE"), fontSize: 12.0, fontWeight: FontWeight.w400);
  static TextStyle bookingDetailsTitle = new TextStyle(
      color: HexColor("#BEBEBE"), fontSize: 12.0, fontWeight: FontWeight.w400);
  static TextStyle listViewSubOne = new TextStyle(
      color: HexColor("#BCBCBC"), fontSize: 12.0, fontWeight: FontWeight.w400);
  static TextStyle gridSubHead = new TextStyle(
      height: 1.5,
      color: HexColor("#FFFFFF"),
      fontSize: 13.0,
      fontWeight: FontWeight.bold);
  static TextStyle gridBAvailable = new TextStyle(
      color: HexColor("#68D389"), fontSize: 12.0, fontWeight: FontWeight.w400);
  static TextStyle previousBookingDndTime = new TextStyle(
      color: HexColor("#53A874"), fontSize: 14.0, fontWeight: FontWeight.w400);
  static TextStyle gridBNotAvailable = new TextStyle(
      color: HexColor("#B4B4B4"), fontSize: 12.0, fontWeight: FontWeight.w400);

  static TextStyle commingSoon = new TextStyle(
      color: HexColor("#FFA500"), fontSize: 12.0, fontWeight: FontWeight.w400);
  static TextStyle tabbarstyle = TextStyle(
      color: HexColor("#FFFFFF"), fontSize: 10.0, fontWeight: FontWeight.w400);
  static TextStyle heading =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle subheading =
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w200);
  static TextStyle label = TextStyle(
      color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.w200);
  static TextStyle tabText = TextStyle(
      color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w200);
  static TextStyle hint = TextStyle(
      color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.w200);

  static final submitButtonStyle = new ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      AppColors.appColor,
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    )),
  );
  static final submitAddPersonButtonStyle = new ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      AppColors.appColor1,
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    )),
  );
  static final appButtonStyle = new ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      HexColor("#68D389"),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7.0),
    )),
  );
  static final disabledSubmitButtonStyle = new ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      HexColor("##BEBEBE"),
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6.0),
    )),
  );
  static final buttonTextStyleBold = new TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w600,
    color: HexColor("#FFFFFF"),
  );
  static final buttonTextStyleBooking = new TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: HexColor("#000000"),
  );
  static final buttonTextStyleSemiBold = new TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: HexColor("#FFFFFF"),
  );
  static final buttonTextStyleSemiBoldBlack = new TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: HexColor("#000000"),
  );
  // static final outlinedSubmitButton = new ButtonStyle(
  //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //     RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8.0),
  //         side: BorderSide(
  //           color: HexColor("#9B8DFD"),
  //           width: 28.0,
  //         )),
  //   ),
  // );

  static final submitButtonText = new TextStyle(
      fontSize: 12.0, fontWeight: FontWeight.w600, color: HexColor("#FFFFFF"));

  // ---- outlined Button style
  static final outLinedButtonStyle = new ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(HexColor("#9B8DFD")),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: HexColor("#9B8DFD")),
      ),
    ),
  );

  static final classOutLinedButtonStyle = new ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(HexColor("#F5F5F5")),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: HexColor("#9B8DFD")),
      ),
    ),
  );

  static final whiteOutlinedButton = new ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.red, width: 5))),
  );

  // --- outLinedButton style
  static final outLinedButtonText = new TextStyle(
    fontFamily: 'nunitoSans',
    color: AppColors.white,
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
  );
  static final whiteOIutLinedButtonText = new TextStyle(
    fontFamily: 'nunitoSans',
    color: HexColor("#747474"),
    fontSize: 12.0,
    fontWeight: FontWeight.w800,
  );

  // --- DropDown shape
  static final dropDownButtonShape = new ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 1.0, color: HexColor("#E0E0E0")),
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
  );
}
