class profileModel {
  bool status;
  int code;
  String message;
  Data data;

  profileModel({this.status, this.code, this.message, this.data});

  profileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int id;
  dynamic image;
  dynamic firstName;
  dynamic lastName;
  String email;
  dynamic desc;
  bool isFirst;
  dynamic points;
  List<Teams> teams;
  dynamic token;

  Data(
      {this.id,
      this.image,
      this.firstName,
      this.lastName,
      this.email,
      this.desc,
      this.isFirst,
      this.points,
      this.teams,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    desc = json['desc'];
    isFirst = json['is_first'];
    points = json['points'];
    if (json['teams'] != null) {
      teams = <Teams>[];
      json['teams'].forEach((v) {
        teams.add(new Teams.fromJson(v));
      });
    }
    token = json['token'];
  }
}

class Teams {
  int id;
  String name;
  dynamic image;
  dynamic type;

  Teams({this.id, this.name, this.image, this.type});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }
}
