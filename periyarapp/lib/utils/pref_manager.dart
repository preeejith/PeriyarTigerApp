import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  // -- parent section
  // static setCurrentStudent(var studentId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('student_id', studentId);
  // }

  // static Future<String?> getCurrentStudent() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('student_id');
  // }
  static setCartId(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cartId', token);
  }

  static getCartId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cartId');
  }

  static setToken(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static setRoomCount(var token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static setTotalSeatCount(var seatCount) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('seatCount', seatCount);
  }

  static getTotalSeatCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('seatCount');
  }

  static getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static setCurrentUser(String currentUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentUser', currentUser);
  }

  static setCurrentRole(String currentRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentRole', currentRole);
  }

  static setIsLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  static getIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') != null) {
      return prefs.getBool('isLoggedIn');
    } else {
      return false;
    }
  }

  static setRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  static Future<String?> getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  static setOnline(String online) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('online', online);
  }

  static Future<String?> getOnline() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('online');
  }
  // static getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

}
