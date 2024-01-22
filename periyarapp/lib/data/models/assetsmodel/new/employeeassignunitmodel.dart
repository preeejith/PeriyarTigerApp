class EmployeeAssignUnitModel {
  EmployeeAssignUnitModel({
      this.status, 
      this.msg,});

  EmployeeAssignUnitModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
  }
  bool? status;
  String? msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['msg'] = msg;
    return map;
  }

}