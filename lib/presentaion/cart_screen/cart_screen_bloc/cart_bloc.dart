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
      List<dynamic> data = [];
      // List data= Hive.box('add_to_cart').get('addedData').values.toList();
      log(Hive.box('add_to_cart').get('addedData').toString(),
          name: "all Data");
      Hive.box('add_to_cart').get('addedData').values.forEach((e) {
        print(e);
        try {
          data.add(e['product']);
        } catch (e) {
          print('Error: $e');
        }
      });
      print(productModelFromJson(data.toString()).first.title);

      emit(
          CartItemsLoadedState(product: productModelFromJson(data.toString())));
    });

    on<CartItemsDeleteEvent>((event, emit) {
      // List data= Hive.box('add_to_cart').get('addedData').values.toList();

      print(
          "DEdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");

      Hive.box('add_to_cart').get('addedData').forEach((key, val) {
        print(val);
        // val.forEach((e,f) {

        print('---------------');
        Map<String, dynamic> m = jsonDecode(val['product']);
        print(m['id']);

        if (m['id'] == event.id) {
          print('mmmmmmmmmmmmmmmmmmmmmmmmmm$key');
          // Map<dynamic, dynamic> fulldata =
          //     jsonDecode(Hive.box('add_to_cart').get('addedData').toString());
          Hive.box('add_to_cart').get('addedData').remove(key);
          // fulldata.remove(key);
          print('remove successsss');
          return;
        }
        // });
        print('=========================');
        print(key);
      });

      // Hive.box('add_to_cart').get('addedData').values.forEach((e) {
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
