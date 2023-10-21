class UserModel {
  String? userId;
  String? name;
  String? facilityName;
  String? facilityType;
  String? region;
  String? address;
  String? lat;
  String? lang;
  String? imageUrl;
  String? token;

  UserModel({
    this.userId,
    this.name,
    this.facilityName,
    this.facilityType,
    this.region,
    this.address,
    this.lat,
    this.lang,
    this.token,
    this.imageUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    facilityName = json['facility_name'];
    facilityType = json['facility_type'];
    region = json['region'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    imageUrl = json['image_url'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['facility_name'] = facilityName;
    data['facility_type'] = facilityType;
    data['region'] = region;
    data['address'] = address;
    data['lat'] = lat;
    data['lang'] = lang;
    data['image_url'] = imageUrl;
    data['token'] = token;
    return data;
  }
}
