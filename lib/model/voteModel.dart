class voiteModel {
  bool status;
  int code;
  String message;
  Data data;

  voiteModel({this.status, this.code, this.message, this.data});

  voiteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int id;
  String details;
  List<Options> options;
  int commentsCount;
  dynamic comment;

  Data({
    this.id,
    this.details,
    this.options,
    this.commentsCount,
    this.comment,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
    commentsCount = json['comments_count'];
    comment = json['comment'];
  }
}

class Options {
  int id;
  String image;
  int vote;
  String percentage;

  Options({this.id, this.image, this.vote, this.percentage});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    vote = json['vote'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['vote'] = this.vote;
    data['percentage'] = this.percentage;
    return data;
  }
}
