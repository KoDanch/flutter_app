import 'package:dio/dio.dart';
import 'package:flutter_app/login_esl/event.dart';
import 'package:flutter_app/login_esl/state.dart';
import 'package:flutter_app/model/postModel.dart';
import 'package:flutter_app/retrofit/ApiService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService apiService;
  LoginBloc(this.apiService) : super(LoginState()) {
    RegExp emailReg = RegExp(r"^[a-zA-Z0-9.!#%&'*+\/=?^_`{|}~-]{1,10}@"
        r"(?:(?!.*--)[a-zA-Z0-9-]{1,10}(?<!-))"
        r"(?:\.(?:[a-zA-Z0-9-]{2,10}))+");

    RegExp passwordReg =
        RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,10}$");

    on<EmailChanged>((event, emit) {
      final emValid = emailReg.hasMatch(event.email);
      emit(state.copyWith(
        email: event.email,
        isEmailValid: emValid,
      ));
    });

    on<PasswordChanged>((event, emit) {
      final pasValid = passwordReg.hasMatch(event.password);
      emit(state.copyWith(
        password: event.password,
        isPasswordValid: pasValid,
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.isEmailValid && state.isPasswordValid) {
        emit(state.copyWith(isSubmitting: true));

        try {
          final data = await fetchUserData();

          //final posts = await fetchPosts();

          emit(state.copyWith(
              isSubmitting: false, isAuth: true, userData: data));
        } catch (e) {
          emit(state.copyWith(isSubmitting: false, errorMessage: "Auth error"));
        }
      }

      if (!emailReg.hasMatch(state.email)) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: "Invalid Email",
        ));
        return;
      }

      if (!passwordReg.hasMatch(state.password)) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: "Invalid pasword",
        ));
        return;
      }
    });
  }
  Future<Map<String, dynamic>> fetchUserData() async {
    final dio = Dio();
    final response = await dio.get("https://randomuser.me/api/");
    if (response.statusCode == 200) {
      return response.data['results'][0];
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<PhotoResponse> fetchPosts() async {
    try {
      final response = await apiService.getPhotos('nature', 50, 1);
      return response;
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }
}
