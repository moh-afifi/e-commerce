class VendorsModel {
  int? statusCode;
  String? message;
  late List<Vendor> vendorsList;

  VendorsModel({this.statusCode, this.message, this.vendorsList = const []});

  VendorsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    vendorsList = <Vendor>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        vendorsList.add(Vendor.fromJson(v));
      });
    }
  }
}

class Vendor {
  String? id;
  String? label;
  String? image;

  Vendor({this.id, this.label, this.image});

  Vendor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    image = json['image'];
  }
}
