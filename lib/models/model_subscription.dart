import 'package:intl/intl.dart';

class Subscription {
  int? id;
  String? company;
  double? price;
  String? period; 
  String? image;
  DateTime? startDate;

  Subscription({
    this.id,
    this.company,
    this.price,
    this.period,
    this.image,
    this.startDate,
  });
  Subscription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    company = json['company'];
    price = json['price']?.toDouble();
    period = json['period'];
    image = json['image'];
    startDate = json['start_date'] != null 
        ? DateTime.parse(json['start_date']) : null;
  }
  Subscription.fromAssetJson(Map<String, dynamic> json) {
    company = json['company'];
    price = json['price']?.toDouble();
    period = json['period'];
    image = json['image'];
    startDate = null; 
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'price': price,
      'period': period,
      'image': image,
      'start_date': startDate?.toIso8601String(),
    };
  }

  DateTime? get expiryDate {
    if (startDate == null || period == null) return null;
    if (period == 'monthly') return DateTime(startDate!.year, startDate!.month + 1, startDate!.day);
    if (period == '6 months') return DateTime(startDate!.year, startDate!.month + 6, startDate!.day);
    if (period == 'yearly') return DateTime(startDate!.year + 1, startDate!.month, startDate!.day);
    return startDate;
  }

  String get formattedStartDate {
    if (startDate == null) return "You didnt define a date";
    return DateFormat('yyyy/MM/dd').format(startDate!);
  }

  String get formattedExpiryDate {
    if (expiryDate == null) return "You didnt define a date";
    return DateFormat('yyyy/MM/dd').format(expiryDate!);
  }
}