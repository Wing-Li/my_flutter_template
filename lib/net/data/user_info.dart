class UserInfo {
  bool success;
  int status;
  String msg;
  String userId;
  String userName;
  String userCode;
  String companyId;
  String companyName;
  String token;
  String refreshToken;

  UserInfo({this.status, this.msg, this.userId, this.companyId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    status = json['Status'];
    msg = json['Msg'];
    userId = json['UserId'];
    token = json['Token'];
    refreshToken = json['RefreshToken'];
    userName = json['userName'];
    userCode = json['userCode'];
    companyId = json['CompanyId'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['UserId'] = this.userId;
    data['Token'] = this.token;
    data['RefreshToken'] = this.refreshToken;
    data['userName'] = this.userName;
    data['userCode'] = this.userCode;
    data['CompanyId'] = this.companyId;
    data['companyName'] = this.companyName;
    return data;
  }
}
