import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';

class EditCartScreen extends StatefulWidget {
  const EditCartScreen({super.key});

  @override
  State<EditCartScreen> createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddToCartProvider>(context);
    final cartKeys = provider.cartItems.keys.toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {

                },
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.shopping_cart),
                    ),
                    Positioned(
                        child: Consumer(
                          builder: (BuildContext context, value, Widget? child) {
                            return provider.totalItems > 0 ?
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Text(
                                provider.totalItems.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ) :
                            const SizedBox.shrink();
                          },
                        )
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: cartKeys.length,
                  itemBuilder: (context, index) {
                    return Consumer<AddToCartProvider>(
                      builder: (context, value, child) {
                        final itemIndex = cartKeys[index];
                        // final itemIndex = _itemIndex +1;
                        return ListTile(
                          title: Text("Item ${itemIndex.toString()}"),
                          trailing: value.cartItems.containsKey(itemIndex) ?
                          Container(
                            height: 30,
                            width: 122,
                            decoration:BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      provider.removeItem(itemIndex);
                                    },
                                    icon: const Icon(Icons.remove,size: 10,)
                                ),
                                const VerticalDivider(color: Colors.black,width: 1,thickness: 1),
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(provider.cartItems[itemIndex].toString(),style: const TextStyle(fontSize: 12)),
                                ),
                                const VerticalDivider(color: Colors.black,width: 1,thickness: 1),
                                IconButton(
                                    onPressed: () {
                                      provider.addItem(itemIndex);
                                    },
                                    icon: const Icon(Icons.add, size: 10,)
                                )
                              ],
                            ),
                          ) :
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                                onPressed: () {
                                  provider.addItem(itemIndex);
                                },
                                child: const Text("Add to Cart")
                            ),
                          ),
                        );
                      },
                    );
                  },)
            )
          ],
        ),
      ),
    );
  }
}
