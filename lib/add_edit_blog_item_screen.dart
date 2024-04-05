import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'blog_item.dart';

class AddEditBlogItemScreen extends StatefulWidget {
  final BlogItem? blogItem;

  const AddEditBlogItemScreen({Key? key, this.blogItem}) : super(key: key);

  @override
  AddEditBlogItemScreenState createState() => AddEditBlogItemScreenState();
}

class AddEditBlogItemScreenState extends State<AddEditBlogItemScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  File? _imageFile;
  int _quantity = 0;
  String _status = 'Out of Stock';

  @override
  void initState() {
    super.initState();
    if (widget.blogItem != null) {
      _titleController.text = widget.blogItem!.title;
      _bodyController.text = widget.blogItem!.body;
      _quantity = widget.blogItem!.quantity;
      _status = widget.blogItem!.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.blogItem == null ? 'Add Blog Item' : 'Edit Blog Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Item name'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
              onChanged: (value) {
                setState(() {
                  _quantity = int.tryParse(value) ?? 0;
                  _status = _quantity > 0 ? 'In Stock' : 'Out of Stock';
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                setState(() {
                  _imageFile =
                      pickedFile != null ? File(pickedFile.path) : null;
                });
              },
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _bodyController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    BlogItem(
                      title: _titleController.text,
                      date: DateTime.now(),
                      body: _bodyController.text,
                      imageUrl: _imageFile?.path,
                      quantity: _quantity,
                      status: _status,
                    ),
                  );
                } else {
                  // Show error message or handle empty fields
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
