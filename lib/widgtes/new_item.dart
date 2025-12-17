import 'package:flutter/material.dart';
import 'package:shoppinglist/data/categories.dart';
import 'package:shoppinglist/models/category.dart';
import 'package:shoppinglist/models/groceryitem.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});
  State<NewItem> createState(){
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem>{
  
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveItem(){
    if (_formKey.currentState!.validate())
    {
    _formKey.currentState!.save();

    Navigator.of(context).pop(
      GroceryItem(
       id: DateTime.now().toString(),
       name: _enteredName,
       quantity: _enteredQuantity,
       category: _selectedCategory
         )
      );
    }
 }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new item...")
      ),
      body: Padding(padding: EdgeInsets.all(12),
        child:Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(
                  label: Text('Name')),
                  validator: (value) {
                    if(value==null || value.isEmpty || value.length>50 || value.length<=1)
                    {
                      return 'Must have a name between 2 and 50 characters.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Expanded(
                  child: TextFormField(
                    keyboardAppearance: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Quantity')
                      ),
                      initialValue: _enteredQuantity.toString(),
                      validator: (value) {
                        if(value==null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)!<=0)
                        {
                          return 'Must Enter a quantity greater than 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField(
                    initialValue: _selectedCategory,
                    items: [
                    for(final category in Categories.entries)
                      DropdownMenuItem(
                        value: category.value,
                        child: Row(children: [
                        Container(
                          width: 16,
                          height: 16,
                          color: category.value.color,
                        ),
                        const SizedBox(width: 6),
                        Text(category.value.name),
                      ],),
                      )
                  ], 
                  onChanged: (value){
                    setState(() {
                      _selectedCategory = value!;
                    });
                  }),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextButton(
                  onPressed: () {
                  _formKey.currentState!.reset();
                }, 
                child: Text("Reset")),
                ElevatedButton(onPressed: _saveItem, child: Text ("Add Item")),
              ],
              )
            ],
          )
        )
      )
    );
  }
}