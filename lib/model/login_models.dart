class LoginModel {
  bool status;
  int code;
  String message;
  User user;

  LoginModel({this.status, this.code, this.message, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int id;
  String image;
  String firstName;
  String lastName;
  String email;
  dynamic desc;
  bool isFirst;
  List<Teams> teams;
  String token;

  User(
      {this.id,
      this.image,
      this.firstName,
      this.lastName,
      this.email,
      this.desc,
      this.isFirst,
      this.teams,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    desc = json['desc'];
    isFirst = json['is_first'];
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
  String image;
  String type;

  Teams({this.id, this.name, this.image, this.type});

  Teams.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
