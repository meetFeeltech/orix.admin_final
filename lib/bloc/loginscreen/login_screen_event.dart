part of 'login_screen_bloc.dart';

abstract class LoginScreenEvents {}

class LoginScreenInitialEvent extends LoginScreenEvents {}

class PostLoginDataEvent extends LoginScreenEvents {
  final String userName;
  final String passWord;

  PostLoginDataEvent(this.userName, this.passWord);
}