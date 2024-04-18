import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wegrow_task_flutter/core/utils/boxes.dart';
import 'package:wegrow_task_flutter/presentaion/cart_screen/cart_screen_bloc/cart_bloc.dart';
import 'package:wegrow_task_flutter/presentaion/details_screen/product_details.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartItemsLoadedEvent());
  }

  int d = -1;

  @override
  Widget build(BuildContext context) {
    final existingAddtoCart = HiveBox().addToCart.get('addedData', defaultValue: {});
    final modifiedAddToCart = Map.from(existingAddtoCart);

    // print("In Ui *****************************");

    // print(modifiedAddToCart);
    // print("In Ui *****************************");

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Column(
        children: <Widget>[
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartItemsLoadedState) {
              // print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
              // print(state.product.length);
              return state.product.isNotEmpty? Expanded(
                child: ListView.builder(
                    itemCount: state.product.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            horizontalTitleGap: 7,
                            dense: false,
                            minVerticalPadding: 0,
                            titleAlignment: ListTileTitleAlignment.titleHeight,
                            leading: Image.network(
                              state.product[index].image,
                              height: 100,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                            title: Text(state.product[index].title),
                            subtitle: Text("৳-${state.product[index].price}"),
                            trailing: IconButton(
                              onPressed: () async {
                                List<int> keysToRemove = [];

                                modifiedAddToCart.forEach((key, value) {
                                  Map<String, dynamic> product = jsonDecode(value['product']);
                                  // print(product['id']);

                                  if (product['id'] == state.product[index].id) {
                                    print('Product ID matched, preparing to remove: ${product['id']}');
                                    keysToRemove.add(int.tryParse(key) ?? 0);
                                  }
                                });

                                // Remove the collected keys from the map
                                for (var key in keysToRemove) {
                                  modifiedAddToCart.remove(key.toString());
                                  print('Removed product with key $key from cart$modifiedAddToCart');
                                }
                                await HiveBox().addToCart.put('addedData', modifiedAddToCart);

                                BlocProvider.of<CartBloc>(context).add(CartItemsLoadedEvent());
                              
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                      );
                    }),
              ):const Center(child: Text("No Data"),);
            } else {
              return const CircularProgressIndicator();
            }
          })
        ],
      ),
    );
  }
}
