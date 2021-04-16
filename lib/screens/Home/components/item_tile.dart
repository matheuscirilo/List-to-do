import 'package:flutter/material.dart';
import 'package:list_to_do/models/item.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    Key key,
    this.item, 
    this.onDelete,
  }) : super(key: key);
  final Item item;
  final Function(Item) onDelete;

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(this.widget.item.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        this.widget.onDelete(this.widget.item);
      },
      background: Container(
        color: Colors.redAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'DELETAR', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )
            ),
            Icon(
              Icons.delete,
              color: Colors.white,
              ),
          ],
        ),
      ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: this.widget.item.done, 
            onChanged: (value){
              setState(() {
                this.widget.item.done = value;
              });
            },
            title: Text(this.widget.item.title),
            subtitle: Text(this.widget.item.subTitle),
            secondary: Icon(Icons.drag_handle),
            ),
            Divider(
              height: 4,
            )
        ],
      ),
    );
  }
}