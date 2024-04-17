import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wegrow_task_flutter/domain/common_functions/common_functions.dart';
import 'package:wegrow_task_flutter/models/product_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProuductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  int index;
  ProuductDetailsScreen({required this.productModel,required this.index, super.key});

  @override
  State<ProuductDetailsScreen> createState() => _ProuductDetailsScreenState();
}

class _ProuductDetailsScreenState extends State<ProuductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
     final existingBookMark = Hive.box('add_to_cart').get('addedData', defaultValue: {});
    final modifiedBookMark = Map.from(existingBookMark);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(radius: 10, child: Text(Hive.box('add_to_cart').get('addedData').values.toList().length.toString(),style: TextStyle(fontSize: 10),)),
              IconButton(onPressed: () {
              }, icon: Icon(Icons.shopping_cart_outlined)),
            ],
          )
          ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Hero(tag: widget.productModel.image, child: Image.network(widget.productModel.image))),
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
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                                          ],
                                        ),
                     
                        IconButton(onPressed: ()async{
                          if (modifiedBookMark.containsKey('${widget.index}')) {
                                          modifiedBookMark.remove('${widget.index}');
                                          CommonFunctions().showToast (message:  "bookMark_removed");
                                        } else {
                                          modifiedBookMark['${widget.index}'] = {'productIndex': widget.index, 'product': jsonEncode(widget.productModel),};
                                          CommonFunctions().showToast (message:  "bookMark_add");
                                        }
                                        await Hive.box('add_to_cart').put('addedData', modifiedBookMark);

                                        setState(() {});
                                      },
                          

                  icon: Hive.box('add_to_cart').get('addedData') != null && Hive.box('add_to_cart').get('addedData').containsKey('${widget.index}')
                                          ? Icon(
                                              Icons.favorite,
                                              color: Colors.green,
                                              size: 20,
                                            )
                                          : Icon(Icons.favorite_border, size: 20, color: Colors.green),
                                    ),
                      ],
                    ),
                Text(
                  widget.productModel.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
