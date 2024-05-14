part of 'login_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

enum LoadingStatus { initial, checking, success }

class LoginState {
  final bool isFormValid;
  final FormStatus formStatus;
  final UsernameInput username;
  final PasswordInput password;
  final LoadingStatus? loaded;
  final bool isFormPosted;
  final bool isPosting;

  const LoginState({
    this.isFormPosted = false,
    this.isFormValid = false,
    this.formStatus = FormStatus.invalid,
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.loaded = LoadingStatus.initial,
    this.isPosting = false,
  });

  LoginState copyWith({
    bool? isFormValid,
    FormStatus? formStatus,
    UsernameInput? username,
    PasswordInput? password,
    LoadingStatus? loaded,
    bool? isFormPosted,
    bool? isPosting,
  }) =>
      LoginState(
        isFormValid: isFormValid ?? this.isFormValid,
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        password: password ?? this.password,
        loaded: loaded ?? this.loaded,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
      );
}
