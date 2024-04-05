import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'blog_item.dart';

class BlogItemScreen extends StatefulWidget {
  final BlogItem blogItem;

  const BlogItemScreen({Key? key, required this.blogItem}) : super(key: key);

  @override
  BlogItemScreenState createState() => BlogItemScreenState();
}

class BlogItemScreenState extends State<BlogItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.blogItem.id}. ${widget.blogItem.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('yyyy-MM-dd').format(widget.blogItem.date)),
            const SizedBox(height: 16.0),
            Text(widget.blogItem.body),
            const SizedBox(height: 16.0),
            if (widget.blogItem.imageUrl != null)
              Image.network(
                widget.blogItem.imageUrl!,
                fit: BoxFit.cover,
                height: 200,
              ),
            const SizedBox(height: 16.0),
            Text('Quantity: ${widget.blogItem.quantity}'),
            Text('Status: ${widget.blogItem.status}'),
          ],
        ),
      ),
    );
  }
}
