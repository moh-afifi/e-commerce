class AddressModel {
  int? statusCode;
  String? message;
  late final List<Address> addressesList;

  AddressModel({this.statusCode, this.message, this.addressesList = const []});

  AddressModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    addressesList = <Address>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        addressesList.add(Address.fromJson(v));
      });
    }
  }
}

class Address {
  String? id;
  String? address;
  String? lat;
  String? lang;

  Address({this.id, this.address, this.lat, this.lang});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
  }
}
