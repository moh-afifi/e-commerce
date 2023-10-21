class AppSateModel {
  late bool isUserActive;
  late bool priceUpdate;
  late double minPrice;
  late double shipping;

  AppSateModel.fromJson(Map<String, dynamic> json) {
    minPrice = double.tryParse('${json['minimum_price']}') ?? 0;
    shipping = double.tryParse('${json['shipping']}') ?? 0;
    isUserActive = int.tryParse('${json['is_active']}') == 1;
    priceUpdate = int.tryParse('${json['price_update']}') == 1;
  }
}
