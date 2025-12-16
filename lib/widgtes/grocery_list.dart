import 'package:flutter/material.dart';
import 'package:shoppinglist/data/dummy_items.dart';
import 'package:shoppinglist/widgtes/new_item.dart';

class Grocerylist extends StatefulWidget{
  const Grocerylist({super.key});

  @override
  State<Grocerylist> createState() => _GrocerylistState();
}

class _GrocerylistState extends State<Grocerylist> {
  void _addItem(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx)=> const NewItem()
      )
    );
  }
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add)
          ),
        ],
      ),
      body:ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder:(ctx,index)=>ListTile(
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          title: Text(groceryItems[index].name),
          trailing: Text(groceryItems[index].quantity.toString())
        )


      )
    );
  }
}