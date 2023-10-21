class DeliveryTimesModel {
  int? statusCode;
  List<DeliveryTime> deliveryTimesList = <DeliveryTime>[];

  DeliveryTimesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    deliveryTimesList = <DeliveryTime>[];
    if (json['message'] != null) {
      json['message'].forEach((v) {
        deliveryTimesList.add(DeliveryTime.fromJson(v));
      });
    }
  }
}

class DeliveryTime {
  String? title;
  String? fromTime;
  String? toTime;

  DeliveryTime.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    fromTime = "${json['from_time']}";
    fromTime = fromTime!.substring(0, fromTime!.length - 3);
    toTime = json['to_time'];
    toTime = toTime!.substring(0, toTime!.length - 3);
  }
}
