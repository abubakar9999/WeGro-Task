part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}
class HomeLoadedState extends HomeState{
  List<ProductModel> products;
  HomeLoadedState({required this.products});
}
