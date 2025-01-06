import 'package:flutter/material.dart';
import 'package:flutter_app/login_esl/event.dart';
import 'package:flutter_app/login_esl/logic.dart';
import 'package:flutter_app/login_esl/state.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.errorMessage!)),
                  );
                }
                if (state.isAuth) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                userData: state.userData!,
                              )));
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign in",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 64),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: TextField(
                            onChanged: (email) {
                              context
                                  .read<LoginBloc>()
                                  .add(EmailChanged(email));
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: "Enter your email",
                              labelText: "Email",
                              errorText: state.isEmailValid
                                  ? null
                                  : "example: test@test.com",
                            ),
                          ));
                    },
                  ),
                  SizedBox(height: 32),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: TextField(
                            onChanged: (password) => context
                                .read<LoginBloc>()
                                .add(PasswordChanged(password)),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: "Enter your password",
                                labelText: "Password",
                                errorText: state.isPasswordValid
                                    ? null
                                    : "Password: 6-10 characters, 1 uppercase, 1 lowercase, 1 digit."),
                          ));
                    },
                  ),
                  SizedBox(height: 48),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 400,
                        ),
                        child: state.isSubmitting
                            ? CircularProgressIndicator()
                            : TextButton(
                                onPressed: () {
                                  context
                                      .read<LoginBloc>()
                                      .add(LoginSubmitted());
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  minimumSize: Size(double.infinity, 48),
                                ),
                                child: Text("Login"),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
