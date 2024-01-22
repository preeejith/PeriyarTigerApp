class PartialBooking {
  bool? status;
  String? id;
  PartialBookingData? data;
  String? msg;

  PartialBooking({this.id, this.msg, this.status, this.data});
  PartialBooking.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    msg = json['msg'];
    data = json['data'] != null
        ? new PartialBookingData.fromJson(json['data'])
        : null;
  }
}

class PartialBookingData {
  int? indian;
  int? children;
  int? foreigner;
  int? indianTotal;
  int? childrenTotal;
  int? foreignerTotal;
  int? programTotal;
  int? bookingTotal;
  int? total;
  String? bookingDate;
  PartialBookingData(
      {this.bookingDate,
      this.bookingTotal,
      this.children,
      this.childrenTotal,
      this.foreigner,
      this.foreignerTotal,
      this.indian,
      this.indianTotal,
      this.programTotal,
      this.total});
  PartialBookingData.fromJson(Map<String, dynamic> json) {
    bookingDate = json['bookingDate'];
    bookingTotal = json['bookingTotal'];
    childrenTotal = json['childrenTotal'];
    children = json['children'];

    foreigner = json['foreigner'];
    foreignerTotal = json['foreignerTotal'];
    indian = json['indian'];
    indianTotal = json['indianTotal'];

    programTotal = json['programTotal'];
    total = json['total'];
  }
}


