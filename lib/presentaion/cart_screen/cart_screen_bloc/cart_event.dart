part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartItemsLoadedEvent extends CartEvent {}

// ignore: must_be_immutable
class CartItemsDeleteEvent extends CartEvent {
  int id;
  CartItemsDeleteEvent({required this.id});
}
