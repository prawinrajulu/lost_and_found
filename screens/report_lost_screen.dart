import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_model.dart';
import '../providers/item_provider.dart';

class ReportLostScreen extends StatefulWidget {
  const ReportLostScreen({Key? key}) : super(key: key);

  @override
  _ReportLostScreenState createState() => _ReportLostScreenState();
}

class _ReportLostScreenState extends State<ReportLostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isLoading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final newItem = ItemModel(
      id: DateTime.now().toString(),
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      imageUrl: '', // Implement image upload separately
      isLost: true,
      location: _locationController.text.trim(),
      date: DateTime.now(),
    );

    try {
      await Provider.of<ItemProvider>(context, listen: false).addItem(newItem);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lost item reported')));
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error reporting item')));
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Lost Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) => val != null && val.isNotEmpty ? null : 'Please enter a title',
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (val) => val != null && val.isNotEmpty ? null : 'Please enter a description',
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (val) => val != null && val.isNotEmpty ? null : 'Please enter location',
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
