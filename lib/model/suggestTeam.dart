class SuggestTeam {
  bool status;
  int code;
  String message;
  Data data;

  SuggestTeam({this.status, this.code, this.message, this.data});

  SuggestTeam.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String name;
  String image;
  String updatedAt;
  String createdAt;
  int id;

  Data({this.name, this.image, this.updatedAt, this.createdAt, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }
}
