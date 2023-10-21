class InvoiceDetails {
  List<Item> itemsList = [];
  double? total;

  InvoiceDetails.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      itemsList = <Item>[];
      json['items'].forEach((v) {
        itemsList.add(Item.fromJson(v));
      });
    }
    total = json['net_total'];
  }
}

class Item {
  String? itemCode;
  String? itemName;
  String? description;
  String? image;
  double? qty;
  String? stockUom;
  String? uom;
  double? stockQty;
  double? rate;
  double? amount;

  Item.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    itemName = json['item_name'];
    description = json['description'];
    image = json['image'];
    qty = double.tryParse('${json['qty']}')??1;
    stockUom = json['stock_uom'];
    uom = json['uom'];
    stockQty = double.tryParse('${json['stockQty']}')??1;
    rate = double.tryParse('${json['rate']}')??0;
    amount = double.tryParse('${json['amount']}')??0;
  }
}
