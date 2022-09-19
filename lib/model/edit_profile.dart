class EditProfie {
  bool status;
  int code;
  String message;
  Data data;

  EditProfie({this.status, this.code, this.message, this.data});

  EditProfie.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int id;
  String name;
  String image;
  String email;
  dynamic emailVerifiedAt;
  int localId;
  int globalId;
  int nationalId;
  dynamic desc;
  int status;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.name,
      this.image,
      this.email,
      this.emailVerifiedAt,
      this.localId,
      this.globalId,
      this.nationalId,
      this.desc,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    localId = json['local_id'];
    globalId = json['global_id'];
    nationalId = json['national_id'];
    desc = json['desc'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
