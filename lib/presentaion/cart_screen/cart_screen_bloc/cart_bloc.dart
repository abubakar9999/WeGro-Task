import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:wegrow_task_flutter/core/utils/boxes.dart';
import 'package:wegrow_task_flutter/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartItemsLoadedEvent>((event, emit) {
      List<dynamic> data = [];
      // List data= HiveBox().addToCart.get('addedData').values.toList();
      log(HiveBox().addToCart.get('addedData').toString(), name: "all Data");
      HiveBox().addToCart.get('addedData').values.forEach((e) {
        print(e);
        try {
          data.add(e['product']);
        } catch (e) {
          print('Error: $e');
        }
      });
      print(productModelFromJson(data.toString()).first.title);

      emit(CartItemsLoadedState(product: productModelFromJson(data.toString())));
    });

    on<CartItemsDeleteEvent>((event, emit)async {








      // HiveBox().addToCart.get('addedData').forEach((key, val) {
      //   print(val);
      //   // val.forEach((e,f) {

      //   print('---------------');
      //   Map<String, dynamic> m = jsonDecode(val['product']);
      //   print(m['id']);

      //   if (m['id'] == event.id) {
      //     print('mmmmmmmmmmmmmmmmmmmmmmmmmm$key');
      //     print(HiveBox().addToCart.get('addedData').runtimeType);
      //     print("xxxxxxxxxx");
      //    var fulldata = HiveBox().addToCart.get('addedData');
      //     print(fulldata.runtimeType);
      //     // HiveBox().addToCart.get('addedData').remove(key);
      //     // fulldata.remove(key);
      //     print('remove successsss');
      //     return;
      //   }
      //   // });
      //   print('=========================');
      //   print(key);
      // });

      // HiveBox().addToCart.get('addedData').values.forEach((e) {
      //   // Map<String, dynamic> product = e['product'] as Map<String, dynamic>;
      //   print('---------------');
      //   Map<String, dynamic> m = jsonDecode(e['product']);
      //   print(m['id']);

      // });

      // emit(
      //     CartItemsLoadedState(product: productModelFromJson(data.toString())));
    });
  }
}
