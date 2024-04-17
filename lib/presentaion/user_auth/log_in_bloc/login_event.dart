part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}
// ignore: must_be_immutable
class LoginLodingEvent extends LoginEvent {
  bool isloading;

  LoginLodingEvent({required this.isloading});
}
