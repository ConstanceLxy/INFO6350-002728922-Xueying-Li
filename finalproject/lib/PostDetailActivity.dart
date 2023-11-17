import 'dart:io';
import 'package:finalproject/Post.dart';
import 'package:flutter/material.dart';

class PostDetailActivity extends StatefulWidget {
  const PostDetailActivity({super.key});

  @override
  State<PostDetailActivity> createState() => _PostDetailActivityState();
}

class _PostDetailActivityState extends State<PostDetailActivity> {
  late Post item;
  late List<String> imgs;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    item = ModalRoute.of(context)?.settings.arguments as Post;
    imgs = item.imgs.split(",");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Post Detail"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  item.title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.desc,
              ),
            ),
            SizedBox(
              height: 100,
              child: GridView.builder(
                  itemCount: imgs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: ((context, index) {
                    return imgs[index].isEmpty
                        ? null
                        : InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("show_pic_page",
                                  arguments: imgs[index]);
                            },
                            child: Image.file(File(imgs[index])));
                  })),
            )
          ],
        ));
  }
}
