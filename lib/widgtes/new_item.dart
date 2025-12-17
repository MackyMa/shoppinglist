import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist/data/categories.dart';
import 'package:shoppinglist/models/category.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});
  State<NewItem> createState(){
    return _NewItemState();
  }
}

class _NewItemState extends State<NewItem>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new item...")
      ),
      body: Padding(padding: EdgeInsets.all(12),
        child:Form(
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
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      label: Text('Quantity')
                      ),
                      initialValue: '1',
                      validator: (value) {
                        if(value==null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)!<=0)
                        {
                          return 'Must Enter a quantity greater than 0';
                        }
                        return null;
                      },
                    ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField(items: [
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
                  ], onChanged: (value){}),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                TextButton(onPressed: () {}, child: Text("Reset")),
                ElevatedButton(onPressed: () {}, child: Text ("Add Item")),
              ],)
            ],
          )
        )
      )
    );
  }
}
