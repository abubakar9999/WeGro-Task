part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

final class LoginInitial extends LoginState {}
class LoginLodingStat extends LoginState {
  bool isLoading;
  LoginLodingStat({required this.isLoading});
  
}
