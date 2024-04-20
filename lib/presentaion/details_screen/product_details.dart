// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wegrow_task_flutter/core/utils/boxes.dart';
import 'package:wegrow_task_flutter/domain/common_functions/common_functions.dart';
import 'package:wegrow_task_flutter/models/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wegrow_task_flutter/presentaion/cart_screen/cart_screen.dart';
import 'package:wegrow_task_flutter/presentaion/cart_screen/cart_screen_bloc/cart_bloc.dart';

// ignore: must_be_immutable
class ProuductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  int index;
  ProuductDetailsScreen(
      {required this.productModel, required this.index, super.key});

  @override
  State<ProuductDetailsScreen> createState() => _ProuductDetailsScreenState();
}

class _ProuductDetailsScreenState extends State<ProuductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final existingAddtoCart =
        HiveBox().addToCart.get('addedData', defaultValue: {});
    final modifiedAddToCart = Map.from(existingAddtoCart);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                  radius: 10,
                  child: Text(
                    HiveBox().addToCart.get('addedData') != null
                        ? HiveBox()
                            .addToCart
                            .get('addedData')
                            .values
                            .toList()
                            .length
                            .toString()
                        : 0.toString(),
                    style: const TextStyle(fontSize: 10),
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
            ],
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Hero(
                  tag: widget.productModel.image,
                  child: Image.network(widget.productModel.image))),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Rating: ${widget.productModel.rating.rate}  '),
                        RatingBarIndicator(
                          rating: widget.productModel.rating.rate,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () async {
                        if (modifiedAddToCart.containsKey('${widget.index}')) {
                          modifiedAddToCart.remove('${widget.index}');
                          CommonFunctions()
                              .showToast(message: "Item remove success");
                        } else {
                          modifiedAddToCart['${widget.index}'] = {
                            'productIndex': widget.index,
                            'product': jsonEncode(widget.productModel),
                          };
                          CommonFunctions()
                              .showToast(message: "Item add success");
                        }
                        await HiveBox()
                            .addToCart
                            .put('addedData', modifiedAddToCart);
                        BlocProvider.of<CartBloc>(context)
                            .add(CartItemsLoadedEvent());

                        setState(() {});
                      },
                      icon: HiveBox().addToCart.get('addedData') != null &&
                              HiveBox()
                                  .addToCart
                                  .get('addedData')
                                  .containsKey('${widget.index}')
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.green,
                              size: 20,
                            )
                          : const Icon(Icons.favorite_border,
                              size: 20, color: Colors.green),
                    ),
                  ],
                ),
                Text(
                  widget.productModel.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(widget.productModel.description)
              ],
            ),
          )),
        ],
      ),
    );
  }
}
