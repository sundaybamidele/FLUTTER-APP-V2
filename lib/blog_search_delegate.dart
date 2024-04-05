import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'blog_item.dart';

class BlogSearchDelegate extends SearchDelegate<BlogItem> {
  final List<BlogItem> items;

  BlogSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
            context,
            BlogItem(
              title: '',
              date: DateTime.now(),
              body: '',
              quantity: 0,
              status: '',
            ));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildList(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildList(query);
  }

  Widget _buildList(String query) {
    final filteredItems = items
        .where((item) =>
            item.title.toLowerCase().contains(query.toLowerCase()) ||
            item.body.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final blogItem = filteredItems[index];
        return ListTile(
          title: Text('${blogItem.id}. ${blogItem.title}'),
          subtitle: Text(DateFormat('yyyy-MM-dd').format(blogItem.date)),
          onTap: () {
            close(context, blogItem);
          },
        );
      },
    );
  }
}
