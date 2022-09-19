class notifications_Model {
  bool status;
  String message;
  Data data;

  notifications_Model({this.status, this.message, this.data});

  notifications_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<DataNotifications> data;

  Data({
    this.data,
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataNotifications>[];
      json['data'].forEach((v) {
        data.add(DataNotifications.fromJson(v));
      });
    }
  }
}

class DataNotifications {
  int id;
  String title;

  DataNotifications({this.id, this.title});

  DataNotifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}
