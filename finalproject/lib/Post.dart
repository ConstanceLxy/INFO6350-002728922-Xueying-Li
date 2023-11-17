class Post {
  final int id;
  final String title;
  final String desc;
  final String price;
  final String imgs;

  Post({
    required this.id,
    required this.title,
    required this.desc,
    required this.price,
    required this.imgs,
  });

  static Post fromMap(Map<String, dynamic> map) {
    return Post(
        id: map["id"],
        title: map["title"],
        desc: map["desc"],
        price: map["price"],
        imgs: map["imgs"]);
  }
}
