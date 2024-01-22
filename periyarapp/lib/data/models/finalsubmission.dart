class FinalSubmissionModel {
  bool? status;
  FinalSubmissionCart? cart;
  String? msg;
  Ticket? ticket;
  FinalSubmissionModel({this.cart, this.msg, this.status});
  FinalSubmissionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    ticket =
        json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
    msg = json['msg'];
    cart = json['cart'] != null
        ? new FinalSubmissionCart.fromJson(json['cart'])
        : null;
  }
}

class Ticket {
  String? id;
  Ticket({this.id});
  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }
}

class FinalSubmissionCart {
  FinalSubmissionCart.fromJson(json);
}
