class Commint {
  bool status;
  int code;
  String message;
  Data data;

  Commint({this.status, this.code, this.message, this.data});

  Commint.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<Datacomment> data;
  String firstPageUrl;
  int lastPage;
  int total;

  Data(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.lastPage,
      this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Datacomment>[];
      json['data'].forEach((v) {
        data.add(Datacomment.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    lastPage = json['last_page'];

    total = json['total'];
  }
}

class Datacomment {
  int id;
  String comment;
  User user;

  Datacomment({this.id, this.comment, this.user});

  Datacomment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int id;
  String name;
  String image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
