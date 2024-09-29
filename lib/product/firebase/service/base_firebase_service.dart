import 'package:flutter_survey_app_web/product/firebase/model/base_firebase_model.dart';

abstract class BaseFirebaseService<T extends BaseFirebaseModel<T>> {
  Future<void> setItem(String collectionPath, T item);
  Future<void> updateItem(String collectionPath, String docId, T item);
  Future<void> deleteItem(
    String collectionPath,
    String docId,
  );
  Future<void> deleteSubCollections(
    List<String> subCollections,
  );
  Future<List<T>> getItems(String collectionPath);
}
