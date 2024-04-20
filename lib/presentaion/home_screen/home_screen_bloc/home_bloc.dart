// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wegrow_task_flutter/domain/repository.dart';
import 'package:wegrow_task_flutter/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeLoadedEvent>((event, emit) async {
      emit(HomeLoadedState(products: await Repository().getProduct()));
    });
  }
}
