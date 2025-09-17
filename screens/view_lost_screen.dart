import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'item_detail_screen.dart';

class ViewLostScreen extends StatelessWidget {
  const ViewLostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Lost Items')),
      body: FutureBuilder(
        future: itemProvider.fetchLostItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemProvider.lostItems.isEmpty) {
            return const Center(child: Text('No lost items found.'));
          }

          return ListView.builder(
            itemCount: itemProvider.lostItems.length,
            itemBuilder: (context, index) {
              final item = itemProvider.lostItems[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.location),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ItemDetailScreen(item: item),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
