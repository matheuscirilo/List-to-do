import 'package:flutter/material.dart';
import 'package:list_to_do/models/item.dart';

import 'components/item_tile.dart';

class HomeScreen extends StatefulWidget {



  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> itens = [];
  _HomeScreenState(){
    this.itens.add(Item('Title','subTitle'));
    this.itens.add(Item('Title','subTitle'));
    this.itens.add(Item('Title','subTitle'));
    this.itens.add(Item('Title','subTitle'));
    this.itens.add(Item('Title','subTitle'));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('To do list')
      ),
      body: ReorderableListView(
        onReorder: onReorder,
        children: this.itens.map((e){
          return ItemTile(
            key: Key('${this.itens.indexOf(e)}'),
            item: e,
            onDelete: (item) {
              setState(() {
                this.itens.remove(item);
              });
            },
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context){
            return MyBottonSheet(
              onSave: (item){
                setState(() {
                  this.itens.add(item);
                });
              }
            );
          },
          backgroundColor: Colors.transparent,
        );
        }, 
        child: Icon(Icons.add), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void onReorder(oldIndex, newIndex) {
        setState(() {
          if(newIndex > oldIndex){
            newIndex -= 1;
          }
          var item = this.itens.removeAt(oldIndex);
          this.itens.insert(newIndex, item);
        });
      }
}

class MyBottonSheet extends StatelessWidget {
  MyBottonSheet({
    Key key, this.onSave,
  }) : super(key: key);
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  final Function(Item) onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: subtitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                 labelText: 'SubTitle',
              ),
            ),
           SizedBox(height: 10,),
           FlatButton(
              onPressed: (){
                var item = Item(
                  this.title.text, 
                  this.subtitle.text
                );
                this.onSave(item);
              }, 
              child: Text(
                'SALVAR',
                style: TextStyle(
                  color: Colors.white,
                )
              ),
              color: Colors.deepPurple,
           ),
          ],
        ),
      ),
    );
  }
}

