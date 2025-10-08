// Step 1: Services folder organization
class PetServiceAPI {
  // Simulated API calls for booking services
  static Future<bool> bookService(String serviceId, DateTime date) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Simulate successful booking (90% success rate)
    return DateTime.now().millisecond % 10 != 0;
  }

  static Future<List<DateTime>> getAvailableSlots(String serviceId) async {
    await Future.delayed(Duration(seconds: 1));

    // Generate some available slots for the next 7 days
    final now = DateTime.now();
    final slots = <DateTime>[];

    for (int i = 1; i <= 7; i++) {
      final date = now.add(Duration(days: i));
      // Add morning and afternoon slots
      slots.add(DateTime(date.year, date.month, date.day, 9, 0));
      slots.add(DateTime(date.year, date.month, date.day, 14, 0));
      slots.add(DateTime(date.year, date.month, date.day, 16, 30));
    }

    return slots;
  }
}
