import '../models/booking.dart';

class BookingService {
  static final List<Booking> _bookings = [];

  static List<Booking> getUserBookings() {
    return List.from(_bookings);
  }

  static void addBooking(Booking booking) {
    _bookings.add(booking);
  }

  static Booking? getBookingById(String id) {
    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  static void cancelBooking(String id) {
    final index = _bookings.indexWhere((booking) => booking.id == id);
    if (index != -1) {
      _bookings[index] = Booking(
        id: _bookings[index].id,
        carId: _bookings[index].carId,
        carName: _bookings[index].carName,
        carImage: _bookings[index].carImage,
        startDate: _bookings[index].startDate,
        endDate: _bookings[index].endDate,
        totalPrice: _bookings[index].totalPrice,
        status: 'Cancelled',
        createdAt: _bookings[index].createdAt,
      );
    }
  }
}
