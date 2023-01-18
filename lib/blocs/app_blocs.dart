import 'package:flutter_bloc/flutter_bloc.dart';

import '../rep/repo.dart';
import './app_events.dart';
import './app_state.dart';

class UserBloc extends Bloc<UserEvents, UserState> {
  final LoadData _loadData;
  final int id;
  UserBloc(this._loadData, this.id) : super(UserLoadingState()) {
    on<LoaderUserEvent>(((event, emit) async {
      if (id == 0) {
        emit(UserLoadingState());
        //emit(UserLoadedState());
        try {
          final users = await _loadData.getDetails();
          emit(UserLoadedState(users));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      } else {
        emit(UserLoadingState());
        //emit(UserLoadedState());
        try {
          final users = await _loadData.getUserDetails(id);
          emit(UserDetailsLoadedState(users));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      }
    }));
  }
}
