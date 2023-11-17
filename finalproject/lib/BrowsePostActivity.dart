import 'package:finalproject/DBManager.dart';
import 'package:finalproject/Post.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BrowsePostActivity extends StatefulWidget {
  const BrowsePostActivity({super.key});

  @override
  State<BrowsePostActivity> createState() => _BrowsePostActivityState();
}

class _BrowsePostActivityState extends State<BrowsePostActivity>
    with WidgetsBindingObserver {
  final List posts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    loadPost();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      loadPost();
    }
  }

  Future<void> loadPost() async {
    final db = await DBManager.getInstance().getDatabase;
    final List<Map<String, dynamic>> maps = await db.query("post");
    posts.clear();
    maps.forEach((element) {
      posts.add(Post.fromMap(element));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("BrowsePost"),
      ),
      body: posts.isEmpty
          ? Center(
              child: Text(
                "Empty Data",
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final Post item = posts[index];
                return ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed("post_detail_page", arguments: item),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.desc),
                  trailing: Text(
                    "\$${item.price}",
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                );
              },
              itemCount: posts.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey,
              ),
            ),
      floatingActionButton: FloatingActionButton.small(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "new_post_page");
          }),
    );
  }
}
