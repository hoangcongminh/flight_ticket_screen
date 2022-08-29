class Date {
  bool? success;
  int? code;
  String? message;
  String? meta;
  List<Data>? data;

  Date({this.success, this.code, this.message, this.meta, this.data});

  Date.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    meta = json['meta'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    data['meta'] = meta;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? currency;
  String? departDate;
  int? totalPrice;
  String? airline;
  int? priceUnit;

  Data(
      {this.currency,
      this.departDate,
      this.totalPrice,
      this.airline,
      this.priceUnit});

  Data.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    departDate = json['departDate'];
    totalPrice = json['totalPrice'];
    airline = json['airline'];
    priceUnit = json['priceUnit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['departDate'] = departDate;
    data['totalPrice'] = totalPrice;
    data['airline'] = airline;
    data['priceUnit'] = priceUnit;
    return data;
  }
}
