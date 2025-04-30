import 'package:cloud_firestore/cloud_firestore.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createBooking(String userId, String vehicleId) async {
    final bookingRef = _firestore.collection('bookings').doc();
    
    await bookingRef.set({
      'userId': userId,
      'vehicleId': vehicleId,
      'startTime': Timestamp.now(),
      'endTime': null,
      'cost': 0.00,
    });

    await _firestore.collection('users').doc(userId).update({
      'bookings': FieldValue.arrayUnion([bookingRef.id]),
    });
  }
}
