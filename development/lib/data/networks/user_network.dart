import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';

class UserNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user chips stream
  Stream<List<ChipModel>> getUserChipsStream(String username) {
    return _firestore
        .collection('chips')
        .where('postedBy', isEqualTo: username)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => ChipModel.fromMap(docSnapshot.data()))
            .toList())
        .handleError((error) {
      throw Exception(error.toString());
    });
  }
}
