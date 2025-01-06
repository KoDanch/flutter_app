import 'package:flutter_app/main_esl/event.dart';
import 'package:flutter_app/main_esl/state.dart';
import 'package:flutter_app/model/userModel.dart';
import 'package:flutter_app/retrofit/ApiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;

  UserBloc(this.apiService) : super(UserInitial()) {
    on<FetchUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        List<UserModel> users = await apiService.getUser();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError("Failed to load user data"));
      }
    });
  }
}
