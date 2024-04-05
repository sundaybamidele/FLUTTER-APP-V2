import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_edit_blog_item_screen.dart';
import 'blog_item.dart';
import 'blog_item_screen.dart';
import 'blog_search_delegate.dart';
import 'package:share_plus/share_plus.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({Key? key}) : super(key: key);

  @override
  BlogListScreenState createState() => BlogListScreenState();
}

class BlogListScreenState extends State<BlogListScreen> {
  final List<BlogItem> _blogItems = [];
  late List<BlogItem> _filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_blogItems);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog List'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Total'),
              Tab(text: 'In Stock'),
              Tab(text: 'Finished'),
              Tab(text: 'Deleted'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: BlogSearchDelegate(_blogItems),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterItems('');
                  },
                ),
              ),
              onChanged: _filterItems,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildTab(_blogItems, 0),
                  _buildTab(_blogItems, 1),
                  _buildTab(_blogItems, 2),
                  _buildTab(_blogItems, 3),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newBlogItem = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEditBlogItemScreen(),
              ),
            );
            if (newBlogItem != null) {
              setState(() {
                _blogItems.add(newBlogItem);
                _filteredItems = List.from(_blogItems);
              });
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTab(List<BlogItem> items, int tabIndex) {
    List<BlogItem> filteredItems = [];
    if (tabIndex == 0) {
      filteredItems = items;
    } else if (tabIndex == 1) {
      filteredItems =
          items.where((item) => item.quantity > 0 && !item.deleted).toList();
    } else if (tabIndex == 2) {
      filteredItems =
          items.where((item) => item.quantity == 0 && !item.deleted).toList();
    } else if (tabIndex == 3) {
      filteredItems = items.where((item) => item.deleted).toList();
    }

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final blogItem = filteredItems[index];
        return ListTile(
          title: Text('${blogItem.id}. ${blogItem.title}'),
          subtitle: Text(DateFormat('yyyy-MM-dd').format(blogItem.date)),
          onTap: () async {
            if (!blogItem.deleted) {
              final updatedBlogItem = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogItemScreen(blogItem: blogItem),
                ),
              );
              if (updatedBlogItem != null) {
                setState(() {
                  items[index] = updatedBlogItem;
                  _filteredItems = List.from(_blogItems);
                });
              }
            }
          },
          leading: Checkbox(
            value: _filteredItems.contains(blogItem),
            onChanged: (value) {
              setState(() {
                if (value!) {
                  _filteredItems.add(blogItem);
                } else {
                  _filteredItems.remove(blogItem);
                }
              });
            },
          ),
          trailing: !blogItem.deleted
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        final updatedBlogItem = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddEditBlogItemScreen(blogItem: blogItem),
                          ),
                        );
                        if (updatedBlogItem != null) {
                          setState(() {
                            items[index] = updatedBlogItem;
                            _filteredItems = List.from(_blogItems);
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        _shareItem(blogItem);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          blogItem.deleted = true;
                          _filteredItems = List.from(_blogItems);
                        });
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.restore),
                      onPressed: () {
                        setState(() {
                          blogItem.deleted = false;
                          _filteredItems = List.from(_blogItems);
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          items.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = _blogItems
          .where((item) =>
              item.title.toLowerCase().contains(query.toLowerCase()) ||
              item.body.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _shareItem(BlogItem item) {
    final text = '${item.title}\n${item.body}';
    Share.share(text);
  }
}
