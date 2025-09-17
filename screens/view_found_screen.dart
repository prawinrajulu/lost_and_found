import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'item_detail_screen.dart';

class ViewFoundScreen extends StatelessWidget {
  const ViewFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Found Items')),
      body: FutureBuilder(
        future: itemProvider.fetchFoundItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (itemProvider.foundItems.isEmpty) {
            return const Center(child: Text('No found items found.'));
          }

          return ListView.builder(
            itemCount: itemProvider.foundItems.length,
            itemBuilder: (context, index) {
              final item = itemProvider.foundItems[index];
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
