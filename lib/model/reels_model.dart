class reels_Model {
  Data data;

  reels_Model({this.data});

  reels_Model.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Data4> data;

  Data({
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data4>[];
      json['data'].forEach((v) {
        data.add(Data4.fromJson(v));
      });
    }
  }
}

class Data4 {
  int id;
  String video;
  int reactionCounts;
  User user;
  int commentsCount;

  bool isLike;
  Data4(
      {this.id,
      this.video,
      this.reactionCounts,
      this.user,
      this.isLike,
      this.commentsCount});

  Data4.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    reactionCounts = json['reaction_counts'];
    commentsCount = json['comments_count'];

    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    isLike = json['is_like'];
  }
}

class User {
  String id;
  String name;
  String image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
