part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartItemsLoadedEvent extends CartEvent {}

class CartItemsDeleteEvent extends CartEvent {
  int id;
  CartItemsDeleteEvent({required this.id});
}
