/////addemployee

class AddEmployeeModel {
  AddEmployeeModel({
    required this.status,
    required this.msg,
  });
  late final bool status;
  late final String msg;

  AddEmployeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['msg'] = msg;
    return _data;
  }
}
