class NotificationsModel {
  int? statusCode;
  String? message;
  late final List<NotificationModel> notificationsList;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    notificationsList = <NotificationModel>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        notificationsList.add(NotificationModel.fromJson(v));
      });
    }
  }
}

class NotificationModel {
  String? id;
  String? title;
  String? subject;
  String? type;
  DateTime? date;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subject = json['subject'];
    type = json['type'];
    date = DateTime.tryParse('${json['date']}');
  }
}
