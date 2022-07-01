import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future updateTimeSpent(int secondsToAdd) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser?.email).update(
        {
          'timeSpent': FieldValue.increment(secondsToAdd),
        },
      );
    } catch (_) {}
  }

  Future<int> getTimeSpent() async {
    try {
      var data = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .get();
      return ((data.data()?['timeSpent'] ?? 0) / 60).toInt();
    } catch (e) {
      return -1;
    }
  }

  Future<int> getDaysSinceJoining() async {
    try {
      var data = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .get();
      return DateTime.now()
          .difference(
            DateTime.parse(
                data.data()?['joiningDate'].toDate().toString() ?? ''),
          )
          .inDays;
    } catch (e) {
      return -1;
    }
  }

  Future addToReadPapers(String pdfLink) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .collection('papersRead')
          .doc(
            pdfLink.substring(pdfLink.lastIndexOf('/') + 1).replaceAll('.', ''),
          )
          .set(
        {
          'read': true,
        },
      );
    } catch (_) {}
  }

  Future<int> getReadPapers() async {
    try {
      var data = await _firestore
          .collection('users')
          .doc(_auth.currentUser?.email)
          .collection('papersRead')
          .get();
      return data.docs.length;
    } catch (e) {
      return -1;
    }
  }
}
