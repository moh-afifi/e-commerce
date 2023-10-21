class ProductModel {
  int? statusCode;
  String? message;
  late List<Product> productList;

  ProductModel({this.statusCode, this.message, this.productList = const []});

  ProductModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    productList = <Product>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        productList.add(Product.fromJson(v));
      });
    }
  }
}

class Product {
  String? id;
  String? uniqueId;
  String? itemName;
  String? description;
  String? image;
  late List<ProductUnit?> productUnitsList;
  late bool isFavorite;
  late bool hasDiscount;
  int? inCart;
  ProductUnit? chosenUnit;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['cart_id'];
    itemName = json['item_name'];
    description = json['description'];
    image = json['image'];
    productUnitsList = <ProductUnit>[];
    if (json['uoms'] != null) {
      json['uoms'].forEach((v) {
        productUnitsList.add(ProductUnit.fromJson(v));
      });
    }
    if (productUnitsList.isNotEmpty) {
      productUnitsList.removeWhere((unit) => unit!.maxAmount < 1 || unit.price == 0);
    }

    isFavorite = int.tryParse(json['is_favorite'].toString()) == 1;
    hasDiscount = int.tryParse(json['discount'].toString()) == 1;
    inCart = json['in_cart'];
    chosenUnit = json['chosen_uom'] != null
        ? ProductUnit.fromJson(json['chosen_uom'])
        : null;
  }

}

class ProductUnit {
  String? id;
  String? name;
  double? price;
  double? quantity;
  late double maxAmount;
  bool isAvailable = true;

  ProductUnit.fromJson(Map<String, dynamic> json) {
    final max = double.tryParse("${json['max_amount']}") ?? 0;
    final current = double.tryParse("${json['current_qty']}") ?? 0;
    id = json['id'];
    name = json['name'];
    price = double.tryParse((json['price']).toString());
    quantity = double.tryParse((json['qty']).toString());
    maxAmount = current < max ? current : max;
    isAvailable = maxAmount >= 1 && price != 0;
  }
}
