import 'package:flutter/material.dart';
import 'package:shoppinglist/data/dummy_items.dart';
import 'package:shoppinglist/models/groceryitem.dart';
import 'package:shoppinglist/widgtes/new_item.dart';

class Grocerylist extends StatefulWidget{
  const Grocerylist({super.key});

  @override
  State<Grocerylist> createState() => _GrocerylistState();
}

class _GrocerylistState extends State<Grocerylist> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async{
    final newItem = await Navigator.of(
      context,
      ).push<GroceryItem>(MaterialPageRoute(builder: (ctx)=> const NewItem()));
      if (newItem == null)
      {
        return;
      }
      else{
        _groceryItems.add(newItem);
      }
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
        itemCount: _groceryItems.length,
        itemBuilder:(ctx,index)=>ListTile(
          leading: Container(
            width: 24,
            height: 24,
            color: _groceryItems[index].category.color,
          ),
          title: Text(_groceryItems[index].name),
          trailing: Text(_groceryItems[index].quantity.toString())
        )


      )
    );
  }
}