class TicketPDF {
  bool? status;
  String? msg;
  TicketPDF({this.msg, this.status});
  TicketPDF.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }
}
