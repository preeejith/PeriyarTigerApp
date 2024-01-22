class CommonModel {
  bool? status;
  String? msg;
  CommonModelData? data;
  CommonModel({this.data, this.status});
  CommonModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? CommonModelData.fromJson(json['data']) : null;
    status = json['status'];
    msg = json['msg'];
  }
}

class CommonModelData {
  String? terms, cancel;
  List<GuestData>? guest;
  CommonModelData({this.terms, this.cancel, this.guest});
  CommonModelData.fromJson(Map<String, dynamic> json) {
    terms = json['terms'];
    cancel = json['cancel'];
    if (json['guest'] != null) {
      guest = <GuestData>[];
      json['guest'].forEach((v) {
        guest!.add(new GuestData.fromJson(v));
      });
    }
  }
}

class GuestData {
  String? id;
  GuestData({this.id});
  GuestData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }
}
