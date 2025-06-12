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
  

  double checkSum() {
    double sum = 0;

    for(final item in items){
      if(items.isEmpty){
        return 0;
      }
      sum += item.price;
    }
    return sum;
  }

  void addToList(Item item) {
    setState(() {
      items.add(item);
      checkSum();

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
      checkSum();
      Navigator.pop(context);
    });
  }

  void onSlide(Item temp) {
    var tempIdx = items.indexOf(temp);
    setState(() {
      items.remove(temp);
      checkSum();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item deleted'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(label: 'Undo', onPressed: () {
          setState(() {
            items.insert(tempIdx, temp);
            checkSum();
          });
        }),),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    double sum = checkSum();
    return Scaffold(
      appBar: AppBar(
        title: Text('Spent It'),
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
            sum == 0 ? Text('No expenses recorded') : Text('You\'ve reached a total of ${sum.toStringAsFixed(2)} in your shopping cart.'),
            SizedBox(height: 25,)
          ],
        ),
      );
  } 
}