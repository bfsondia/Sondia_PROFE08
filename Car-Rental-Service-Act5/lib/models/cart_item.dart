import 'car.dart';

class CartItem {
  final String id;
  final Car car;
  final DateTime startDate;
  final DateTime endDate;
  final bool insurance;
  final bool gps;
  final bool childSeat;

  CartItem({
    required this.id,
    required this.car,
    required this.startDate,
    required this.endDate,
    this.insurance = false,
    this.gps = false,
    this.childSeat = false,
  });

  int get rentalDays {
    return endDate.difference(startDate).inDays + 1;
  }

  double get totalPrice {
    double basePrice = car.pricePerDay * rentalDays;
    double extras = 0;

    if (insurance) extras += 15 * rentalDays;
    if (gps) extras += 10 * rentalDays;
    if (childSeat) extras += 5 * rentalDays;

    return basePrice + extras;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'car': car.toJson(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'insurance': insurance,
      'gps': gps,
      'childSeat': childSeat,
    };
  }
}
