import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/firestore_service.dart';

class ItemProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<ItemModel> _lostItems = [];
  List<ItemModel> _foundItems = [];

  List<ItemModel> get lostItems => _lostItems;
  List<ItemModel> get foundItems => _foundItems;

  Future<void> fetchLostItems() async {
    _lostItems = await _firestoreService.getItems(isLost: true);
    notifyListeners();
  }

  Future<void> fetchFoundItems() async {
    _foundItems = await _firestoreService.getItems(isLost: false);
    notifyListeners();
  }

  Future<void> addItem(ItemModel item) async {
    await _firestoreService.addItem(item);
    if (item.isLost) {
      await fetchLostItems();
    } else {
      await fetchFoundItems();
    }
  }
}
