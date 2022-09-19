class post_model {
  Data data;

  post_model({this.data});

  post_model.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<Data3> data;

  Data({
    this.currentPage,
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data3>[];
      json['data'].forEach((v) {
        data.add(Data3.fromJson(v));
      });
    }
  }
}

class Data3 {
  int id;
  String details;
  String image;
  dynamic link;
  dynamic owner;

  List<Options> options;
  int commentsCount;
  Comment comment;
  int reactionCounts;
  List<Reactions> reactions;
  bool isLike;

  Data3(
      {this.id,
      this.details,
      this.image,
      this.options,
      this.owner,
      this.link,
      this.commentsCount,
      this.comment,
      this.reactionCounts,
      this.reactions,
      this.isLike});

  Data3.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    details = json['details'];
    owner = json['owner'] ?? '';
    link = json['link'] ?? '';
    image = json['image'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(Options.fromJson(v));
      });
    }
    commentsCount = json['comments_count'];
    comment =
        json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
    reactionCounts = json['reaction_counts'];
    if (json['reactions'] != null) {
      reactions = <Reactions>[];
      json['reactions'].forEach((v) {
        reactions.add(new Reactions.fromJson(v));
      });
    }
    isLike = json['is_like'];
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
}

class Comment {
  int id;
  String comment;
  User user;

  Comment({this.id, this.comment, this.user});

  Comment.fromJson(Map<String, dynamic> json) {
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

class Reactions {
  int reaction;
  String icon;

  Reactions({this.reaction, this.icon});

  Reactions.fromJson(Map<String, dynamic> json) {
    reaction = json['reaction'];
    icon = json['icon'];
  }
}
