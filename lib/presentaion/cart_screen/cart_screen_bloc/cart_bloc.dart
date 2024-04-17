import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:wegrow_task_flutter/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartItemsLoadedEvent>((event, emit) {
      // List data= Hive.box('add_to_cart').get('addedData').values.toList();
      List<ProductModel> data=[];
   
     Hive.box('add_to_cart').get('addedData').values.forEach((e){
      
      try {
        print(e['product'].runtimeType);
          data.add(productModelFromJson(e['product']) as ProductModel);

     
      } catch (e) {
        log(e.toString());
        
      }
    
     });
     
     log(data.toString(),name: "my Data");
    // print(Hive.box('add_to_cart').get('addedData').values['product']);
      // print(data);

     emit(CartItemsLoadedState(productModel: data));

   
    });
  }
}
