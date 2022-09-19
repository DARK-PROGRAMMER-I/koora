class my_messages {
  Message message;

  my_messages({this.message});

  my_messages.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }
}

class Message {
  dynamic message;
  dynamic image;
  User user;

  Message({this.message, this.image, this.user});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    image = json['image'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  dynamic id;
  dynamic name;
  dynamic image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
