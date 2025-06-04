import 'package:flutter/material.dart';
import 'package:spent_it/models/items_list.dart';
import 'package:spent_it/models/item.dart';
import 'package:spent_it/windows/new_item.dart';

class SpentIt extends StatefulWidget {
  const SpentIt({super.key});

  @override
  State<StatefulWidget> createState() => _spentItState();
}

class _spentItState extends State<SpentIt> {

  List<Item> items = [];

  void addToList(Item item) {
    setState(() {
      items.add(item);
    });
  }

  void onPress() {
    showModalBottomSheet(
      context: context, 
      builder: (ctx) => NewItem(addToList: addToList),
    );
  }

  void clearPage() {
    setState(() {
      items = [];
    });
  }

  void onSlide(Item temp) {
    setState(() {
      items.remove(temp);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spent It'),
        backgroundColor: Color.fromARGB(255, 220, 239, 255),
        actions: [
          IconButton(onPressed: () {
            showDialog(context: context, builder: (ctx) => AlertDialog(title: Text('Delete cart') ,content: Text('Are you sure you want to delete your entire cart?'),actions: [
              ElevatedButton(
                onPressed: clearPage,
                child: Text('Yes')),
              ElevatedButton(onPressed: () {Navigator.pop(ctx);}, child: Text('No'),)
            ],));
          }, icon: Icon(Icons.delete),), 
          IconButton(
            onPressed: onPress, 
            icon: Icon(Icons.add),
            ),
        ],
        
      ),
        body: Column(
          children: [
            items.isEmpty ? Text('The cart is empty') : Text('The cart'),
            Expanded(child: ItemsList(items: items, onSlide: onSlide,),),
          ],
        ),
      );
  }
}