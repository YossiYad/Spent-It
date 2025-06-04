//item List class
import 'package:flutter/material.dart';
import 'package:spent_it/models/item.dart';
import 'package:spent_it/widgets/Cards.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.items, required this.onSlide});

  final List<Item> items;
  final void Function(Item) onSlide;

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        itemCount: items.length ,
        itemBuilder: (ctx, idx) => Dismissible(key: ValueKey(items[idx]), child: Cards(item: items[idx]), onDismissed: (direction) {onSlide(items[idx]);},),
        );
    
  }
}