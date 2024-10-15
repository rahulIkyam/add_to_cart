import 'package:flutter/material.dart';

class AddFavourite extends StatefulWidget {
  const AddFavourite({super.key});

  @override
  State<AddFavourite> createState() => _AddFavouriteState();
}

class _AddFavouriteState extends State<AddFavourite> {

  List selectedItems = [];
  @override
  Widget build(BuildContext context) {
    print("--------build-------");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                itemCount: 50,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if(selectedItems.contains(index)){
                          selectedItems.add(index);
                          // selectedItems.remove(index);
                        }else{
                          selectedItems.remove(index);
                        }
                      },
                      title: Text("Item ${index.toString()}"),
                      trailing: Icon(selectedItems.contains(index) ? Icons.favorite : Icons.favorite_outline),
                    );
                  },
              )
          )
        ],
      ),
    );
  }
}
