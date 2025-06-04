//item class
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';// מסדר תאריכים

final formatterDate = DateFormat('dd/MM/yyyy');

const icons = {
  Category.clothes: Icons.checkroom,
  Category.food: Icons.fastfood,
  Category.home: Icons.store,
  Category.pleasure: Icons.emoji_emotions,
  Category.studies: Icons.school,
  Category.vacations: Icons.flight_takeoff,
};

enum Category {select ,food, pleasure, clothes, vacations, home, studies}

final uuid = Uuid();

class Item {
  Item({
    required this.date,
    required this.price,
    required this.product,
    required this.category,
    }
  ) : id = uuid.v4();

  final String id;
  final String product;
  final double price;
  final DateTime date;
  final Category category;

  String get formatedDate => formatterDate.format(date);
}