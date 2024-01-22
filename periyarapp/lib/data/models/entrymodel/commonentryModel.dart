class CommonEntryModel {
  bool? status;
  String? msg;

  CommonEntryModel({this.msg, this.status});
  CommonEntryModel.fromJson(Map<String, dynamic> json) {
  
    status = json['status'];
    msg = json['msg'];
  }
}