//new item class
import 'package:spent_it/models/item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';// מסדר תאריכים

final formatterDate = DateFormat('dd/MM/yyyy');

class NewItem extends StatefulWidget {
  const NewItem({super.key, required this.addToList});
 
  final void Function(Item) addToList; 
  

  @override
  State<NewItem> createState() => _NewItemState();
}


class _NewItemState extends State<NewItem> {
  
  final inputController = TextEditingController();
  final priceController = TextEditingController(); 
  DateTime? _selectedDate;
  Category _selectedCategory = Category.select;
  
  @override
  void dispose() {
    inputController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void saveButtun() {
    // ERORR Massage
    var inputBool = inputController.text.isEmpty;
    var priceNumber = double.tryParse(priceController.text);
    var priceValid = priceNumber == null || priceNumber <= 0;
    var dateBool = _selectedDate == null;

    if(inputBool || priceValid || dateBool) {
      showDialog(context: context, builder: (ctx) =>
        AlertDialog(
          title: Row(children: [ Icon(Icons.error),SizedBox(width: 5,),Text('Invalid input'),],),
          content: Text('Please make sure a valid title, price, date and category was entered.'),
          actions: [
            ElevatedButton(onPressed: () {Navigator.pop(ctx);}, child: Text('Continue'),),
          ],
        )
      ); 
      return;
    }
    else {
      Item temp = Item(date: _selectedDate!, price: priceNumber, product: inputController.text, category: _selectedCategory);
       widget.addToList(temp);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: inputController,
              maxLength: 50,
              keyboardType: TextInputType.text, //  איזה מקלדת? מספרים? טקסט?... בדיפולט זה המצב ולכן אין צורך, אך לצורך הלימוד שמתי
              decoration: InputDecoration(
                label: Text('Title'),
              ),),
            Row(
              children: [
              Expanded(
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '₪ ',
                    label: Text(
                      'Price'
                    ),
                  ),
                ),
              ),
              SizedBox(width: 60,),
              Text(_selectedDate == null ? 'No selected Date' : formatterDate.format(_selectedDate!)),
              IconButton(
                onPressed: () async {
                final now = DateTime.now();
                final firstDate = DateTime(now.year - 1, now.month, now.day);
                final pickedDate = await showDatePicker(
                  context: context, 
                  firstDate: firstDate, 
                  lastDate: now, 
                  initialDate: now);
                setState(() {
                  _selectedDate = pickedDate;
                });
              }, 
              icon: Icon(Icons.calendar_month)),
            ],
          ),
          SizedBox(height: 10,),
          Row(children: [
            DropdownButton(
              value: _selectedCategory,
              items: Category.values.map((value) => DropdownMenuItem(value: value ,child: Text(value.name)),).toList(), 
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              }),
            const Spacer(),
            TextButton(onPressed: () {}, child: Text('cancel'),),
            ElevatedButton(onPressed: saveButtun, child: Text('Save Product'),),
          ],),
          ],
          ),
        ),
        );
  }
}