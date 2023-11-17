import 'dart:io';

import 'package:camera/camera.dart';
import 'package:finalproject/DBManager.dart';
import 'package:finalproject/FireAuth.dart';
import 'package:finalproject/TakePictureActivity.dart';
import 'package:flutter/material.dart';

import 'FireStore.dart';

class NewPostActivity extends StatefulWidget {
  const NewPostActivity({super.key});

  @override
  State<NewPostActivity> createState() => _NewPostActivityState();
}

class _NewPostActivityState extends State<NewPostActivity> {
  String title = "", desc = "", price = "";
  List<String> imgs = ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("HyperGarageSale"),
          actions: [
            IconButton(
              onPressed: save,
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Enter title of the item",
              ),
              onChanged: (value) => title = value,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter price",
              ),
              onChanged: (value) => price = value,
            ),
            TextField(
              maxLines: 15,
              minLines: 10,
              decoration: InputDecoration(
                hintText: "Enter description of the item",
              ),
              onChanged: (value) => desc = value,
            ),
            SizedBox(
              height: 100,
              child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: ((context, index) {
                    return imgs[index].isEmpty
                        ? InkWell(
                            onTap: () {
                              take(index);
                            },
                            child: Icon(Icons.add))
                        : InkWell(
                            onTap: () {
                              take(index);
                            },
                            child: Image.file(File(imgs[index])));
                  })),
            )
          ],
        ));
  }

  Future<void> take(int index) async {
    Navigator.of(context).pushNamed("take_page").then((value) {
      print(value);
      if (value != null) {
        imgs[index] = (value as XFile).path;
        setState(() {});
      }
    });
  }

  Future<void> save() async {
    if (price.isEmpty || desc.isEmpty || title.isEmpty) {
      showSnackBar('Please fill in all the fields!');
      return;
    }

    if (imgs.length > 0) {
      imgs.forEach((element) {
        FireStore.uploadImage(path: element);
      });
    }

    final db = await DBManager.getInstance().getDatabase;
    Map<String, Object> values = {
      "id": DateTime.now().millisecondsSinceEpoch,
      "title": title,
      "desc": desc,
      "price": price,
      "imgs": imgs.join(",")
    };
    final res = await db.insert("post", values);
    print("res:$res");
    if (res > 0) {
      showSnackBar('Post Success!');
      Navigator.of(context).pop();
    } else {
      showSnackBar('Post Fail!');
    }
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }
}
