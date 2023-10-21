class EntityModel {
  int? statusCode;
  String? message;
  late final List<Entity> entitiesList;

  EntityModel({this.statusCode, this.message, this.entitiesList = const []});

  EntityModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    entitiesList = <Entity>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        entitiesList.add(Entity.fromJson(v));
      });
    }
  }
}

class Entity {
  String? value;
  double? minimumPrice;

  Entity({this.value, this.minimumPrice});

  Entity.fromJson(Map<String, dynamic> json) {
    value = json['id'];
    minimumPrice = double.tryParse('${json['minimum_price']}');
  }
}
