class Booking {
  final String id;
  final String carId;
  final String userName;
  final String email;
  final String phone;
  final DateTime pickupDate;
  final DateTime returnDate;
  final String pickupLocation;
  final String returnLocation;
  final double totalPrice;
  final String? additionalNotes;

  Booking({
    required this.id,
    required this.carId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.pickupDate,
    required this.returnDate,
    required this.pickupLocation,
    required this.returnLocation,
    required this.totalPrice,
    this.additionalNotes,
  });

  int get rentalDays {
    return returnDate.difference(pickupDate).inDays;
  }
}
