part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

final class CartInitial extends CartState {}

final class CartItemsLoadedState extends CartState {
  List<ProductModel> product;
  CartItemsLoadedState({
    required this.product,
  });
}
