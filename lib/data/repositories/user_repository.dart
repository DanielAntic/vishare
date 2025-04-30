import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<Map<String, dynamic>> getUserData() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final DocumentSnapshot doc = 
      await _firestore.collection('users').doc(user.uid).get();
    
    return doc.data() as Map<String, dynamic>? ?? {};
  }


  Stream<QuerySnapshot> getBookingsStream() {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    return _firestore
      .collection('bookings')
      .where('userId', isEqualTo: user.uid)
      .snapshots();
  }
}
