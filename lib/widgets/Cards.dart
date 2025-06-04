//class Card
import 'package:flutter/material.dart';
import 'package:spent_it/models/item.dart';

class Cards extends StatelessWidget {
  const Cards({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 8,
      ),
      child: Card(
        
        elevation: 18,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(children: 
            [ 
              SizedBox(width: 10,),
              Text(
              item.product,
              ),
              Row(
                children: [
                  Text('${item.price.toStringAsFixed(2)} ₪'),
                  const Spacer(),
                  Row(children: [
                    Icon(icons[item.category]),
                    SizedBox(width: 5,),
                    Text(item.formatedDate),
                  ],),
                ],  
              ),
            ],
          ),
        ),
      ),
    );
  }
}
