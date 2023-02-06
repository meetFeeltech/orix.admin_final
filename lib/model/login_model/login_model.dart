class login_model {
  String? message;
  String? accessToken;
  UserData? userData;

  login_model({this.message, this.accessToken, this.userData});

  login_model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userName;
  String? email;
  String? role;

  UserData({this.userName, this.email, this.role});

  UserData.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['role'] = this.role;
    return data;
  }
}
