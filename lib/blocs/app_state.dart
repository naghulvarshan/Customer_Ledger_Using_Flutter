import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../get.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final List<User> users;
  UserLoadedState(this.users);
  @override
  List<Object> get props => [users];
}

class UserDetailsLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserDetailsLoadedState extends UserState {
  final User users;
  UserDetailsLoadedState(this.users);
  @override
  List<Object> get props => [users];
}

class UserErrorState extends UserState {
  final String msg;
  UserErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
