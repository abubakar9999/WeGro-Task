import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wegrow_task_flutter/presentaion/home_screen/home_screen_bloc/home_bloc.dart';
import 'package:wegrow_task_flutter/presentaion/user_auth/log_in_bloc/login_bloc.dart';

class AllBlocProviders {
  static List getAllBlocProviders=[
 BlocProvider(create: (context)=> LoginBloc()),
 BlocProvider(create: (context)=> HomeBloc())
  ];
  
}