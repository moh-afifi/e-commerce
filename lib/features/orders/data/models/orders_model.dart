class InvoicesModel {
  int? statusCode;
  String? message;
  List<Invoice> ordersList = [];

  InvoicesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    ordersList = <Invoice>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        ordersList.add(Invoice.fromJson(v));
      });
    }
  }
}

class Invoice {
  String? orderNo;
  String? status;
  late DateTime createdAt;
  String? address;
  double? totalAmount;
  String? invoiceLink;

  Invoice.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    status = json['status'];
    createdAt = DateTime.tryParse('${json['created_at']}') ?? DateTime.now();
    address = json['address'];
    totalAmount = double.tryParse('${json['total_amount']}') ?? 0;
    invoiceLink = '${json['invoice_pdf']}';
    invoiceLink = invoiceLink?.replaceAll(' ', '+');
  }
}
