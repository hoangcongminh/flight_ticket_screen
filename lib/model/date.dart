class Date {
  bool? success;
  int? code;
  String? message;
  String? meta;
  List<DateItem>? data;

  Date({this.success, this.code, this.message, this.meta, this.data});

  Date.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    meta = json['meta'];
    if (json['data'] != null) {
      data = <DateItem>[];
      json['data'].forEach((v) {
        data!.add(DateItem.fromJson(v));
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

class DateItem {
  String? currency;
  DateTime? departDate;
  int? totalPrice;
  String? airline;
  int? priceUnit;

  DateItem({
    this.currency,
    this.departDate,
    this.totalPrice,
    this.airline,
    this.priceUnit,
  });

  DateItem.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    departDate = DateTime.parse(json['departDate']);
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

  DateItem copyWith({
    String? currency,
    DateTime? departDate,
    int? totalPrice,
    String? airline,
    int? priceUnit,
  }) {
    return DateItem(
      currency: currency ?? this.currency,
      departDate: departDate ?? this.departDate,
      totalPrice: totalPrice ?? this.totalPrice,
      airline: airline ?? this.airline,
      priceUnit: priceUnit ?? this.priceUnit,
    );
  }
}
