import 'dart:math';

class Item {
  String title;
  String subTitle;
  bool done = false;
  int id = Random().nextInt(100000);

  Item(this.title, this.subTitle);
}