import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResultsController extends GetxController {
  var results = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchResults();
  }

  Future<void> fetchResults() async {
    isLoading.value = true;
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        CollectionReference resultsCollection = _firestore
            .collection('users')
            .doc(user.uid)
            .collection('results');

        QuerySnapshot querySnapshot =
            await resultsCollection.orderBy('timestamp', descending: true).get();

        results.value = querySnapshot.docs.map((doc) {
          return {
            'label': doc['label'],
            'confidence': doc['confidence'],
            'timestamp': doc['timestamp'].toDate().toString(),
            // 'image_url': doc['image_url'] ?? '',
          };
        }).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load results');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveResult(String label, double confidence) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('results')
            .add({
          'label': label,
          'confidence': confidence,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to save result');
    }
  }
}
