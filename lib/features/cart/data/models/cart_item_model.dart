class ItemModel {
  String? itemCode;
  String? uniqueId;
  String? uom;
  double? qty;
  double? unitPrice;
  double? maxQuantity;

  ItemModel({
    required this.itemCode,
    required this.uniqueId,
    required this.uom,
    required this.qty,
    required this.unitPrice,
    required this.maxQuantity,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_code'] = itemCode;
    data['uniqueId'] = uniqueId;
    data['uom'] = uom;
    data['qty'] = qty;
    data['unitPrice'] = unitPrice;
    data['maxQuantity'] = maxQuantity;
    return data;
  }
}
