import 'dart:async';

import 'package:add_to_cart/provider/cart_provider.dart';
import 'package:add_to_cart/screens/edit_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddToCartProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add"),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => EditCartScreen(),));
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
                  itemCount: 50,
                  itemBuilder: (context, index) {
              return Consumer<AddToCartProvider>(
                builder: (context, value, child) {
                  int item = index+1;
                  return ListTile(
                    title: Text("Item ${index.toString()}"),
                    trailing: value.cartItems.containsKey(index) ?
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
                                provider.removeItem(index);
                              },
                              icon: const Icon(Icons.remove,size: 10,)
                          ),
                          const VerticalDivider(color: Colors.black,width: 1,thickness: 1),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(provider.cartItems[index].toString(),style: const TextStyle(fontSize: 12)),
                          ),
                          const VerticalDivider(color: Colors.black,width: 1,thickness: 1),
                          IconButton(
                              onPressed: () {
                                provider.addItem(index);
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
                            provider.addItem(index);
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
