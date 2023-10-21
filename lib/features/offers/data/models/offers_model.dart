class OffersModel {
  int? statusCode;
  String? message;
  late List<Offer> offersList;

  OffersModel({this.statusCode, this.message, this.offersList = const []});

  OffersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    offersList = <Offer>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        offersList.add(Offer.fromJson(v));
      });
    }
  }
}

class Offer {
  String? id;
  String? title;
  String? image;

  Offer({this.id, this.title, this.image});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}
