import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserEvents extends Equatable {
  const UserEvents();
}

class LoaderUserEvent extends UserEvents {
  @override
  List<Object?> get props => [];
}

class LoaderUserDetailsEvents extends UserEvents {
  @override
  List<Object?> get props => [];
}
