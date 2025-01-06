class LoginState {
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isAuth;
  final bool isEmailValid;
  final bool isPasswordValid;
  final Map<String, dynamic>? userData;

  LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.errorMessage,
    this.isAuth = false,
    this.isEmailValid = true,
    this.isPasswordValid = true,
    this.userData,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    bool? isAuth,
    bool? isEmailValid,
    bool? isPasswordValid,
    Map<String, dynamic>? userData,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        errorMessage: errorMessage,
        isAuth: isAuth ?? this.isAuth,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        userData: userData ?? this.userData);
  }
}
