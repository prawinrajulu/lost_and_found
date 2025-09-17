import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemDetailScreen extends StatelessWidget {
  final ItemModel item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item.imageUrl.isNotEmpty
                ? Image.network(item.imageUrl)
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            Text('Description: ${item.description}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Location: ${item.location}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Date: ${item.date.toLocal()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              item.isLost ? 'Status: Lost' : 'Status: Found',
              style: TextStyle(
                fontSize: 16,
                color: item.isLost ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
