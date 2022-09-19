class RegisterModel {
  bool status;
  dynamic code;
  dynamic message;
  dynamic data;

  RegisterModel({this.status, this.code, this.message, this.data});

  RegisterModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic email;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  Data({this.email, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
