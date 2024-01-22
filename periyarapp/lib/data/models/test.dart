class TermsAndPolicy {
  bool? status;
  TermsAndPolicyData? data;
  String? msg;

  TermsAndPolicy({this.data, this.msg, this.status});
  TermsAndPolicy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? TermsAndPolicyData.fromJson(json['data']) : null;
    msg = json['msg'];
  }
}

class TermsAndPolicyData {
  String? terms, cancel;
  TermsAndPolicyData({this.cancel, this.terms});
  TermsAndPolicyData.fromJson(Map<String, dynamic> json) {
    terms = json['terms'];
    cancel = json['cancel'];
  }
}
