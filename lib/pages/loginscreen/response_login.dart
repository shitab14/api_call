class LoginResponse {
  late String? refresh;
  late String? access;
  late String? detail;

  LoginResponse({required this.refresh, required this.access, required this.detail});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    data['detail'] = this.detail;

    return data;
  }

}
