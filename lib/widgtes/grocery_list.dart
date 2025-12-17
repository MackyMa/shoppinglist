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

  void _removeItem(GroceryItem item){
    setState(() {
       _groceryItems.remove(item);
    });
    for(var i = 0; i < _groceryItems.length; i++)
    {
      print(_groceryItems[i].name);
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    Widget context = const Center(child: Text("Please Click the + Button to add an item"));
    if (_groceryItems.isNotEmpty)
    {
      context = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder:(ctx,index)=>Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            title: Text(_groceryItems[index].name),
            trailing: Text(_groceryItems[index].quantity.toString())
          ),
        )
      );
    }
     
    


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
      body: context,
    );
  }
}