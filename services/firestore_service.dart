import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item_model.dart';
class FirestoreService {
  final CollectionReference _itemsCollection =
  FirebaseFirestore.instance.collection('items');

  Future<List<ItemModel>> getItems({required bool isLost}) async {
    try {
      QuerySnapshot snapshot = await _itemsCollection
          .where('isLost', isEqualTo: isLost)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return ItemModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch items: $e');
    }
  }

  Future<void> addItem(ItemModel item) async {
    try {
      await _itemsCollection.doc(item.id).set(item.toMap());
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }

  Future<ItemModel?> getItemById(String id) async {
    try {
      DocumentSnapshot doc = await _itemsCollection.doc(id).get();
      if (doc.exists) {
        return ItemModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get item: $e');
    }
  }
}
