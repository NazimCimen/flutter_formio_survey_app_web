import 'package:flutter_survey_app_web/core/error/exception.dart';
import 'package:flutter_survey_app_web/product/constants/app_durations.dart';
import 'package:flutter_survey_app_web/product/firebase/model/base_firebase_model.dart';
import 'package:flutter_survey_app_web/product/firebase/service/base_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServiceImpl<T extends BaseFirebaseModel<T>>
    implements BaseFirebaseService<T> {
  final FirebaseFirestore firestore;

  FirebaseServiceImpl({
    required this.firestore,
  });

  @override
  Future<void> setItem(String collectionPath, T item) async {
    await firestore
        .collection(collectionPath)
        .doc(item.id)
        .set(item.toJson())
        .timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('Image upload timed out');
      },
    );
  }

  @override
  Future<void> updateItem(String collectionPath, String docId, T item) async {
    await firestore
        .collection(collectionPath)
        .doc(docId)
        .update(item.toJson())
        .timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('Image upload timed out');
      },
    );
  }

  @override
  Future<void> deleteItem(
    String collectionPath,
    String docId,
  ) async {
    await firestore.collection(collectionPath).doc(docId).delete().timeout(
      AppDurations.timeoutDuration,
      onTimeout: () {
        throw TimeoutException('Image upload timed out');
      },
    );
  }

  @override
  Future<void> deleteSubCollections(
    List<String> subCollections,
  ) async {
    for (final subCol in subCollections) {
      final snapshots = await firestore.collection(subCol).get();
      for (final doc in snapshots.docs) {
        await doc.reference.delete().timeout(
          AppDurations.timeoutDuration,
          onTimeout: () {
            throw TimeoutException('Image upload timed out');
          },
        );
      }
    }
  }

  @override
  Future<List<T>> getItems(String collectionPath) {
    // TODO: implement getItems
    throw UnimplementedError();
  }

  /* @override
  Future<List<T>> getItems(String collectionPath) async {
    final snapshot = await firestore.collection(collectionPath).get();
    return snapshot.docs.map((doc) => fromJson(doc.data())).toList();
  }*/
}
