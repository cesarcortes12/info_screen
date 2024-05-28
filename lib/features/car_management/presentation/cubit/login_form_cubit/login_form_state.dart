part of 'login_form_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

//enum LoadingStatus { initial, checking, success }

class LoginFormState {
  final bool isFormValid;
  final FormStatus formStatus;
  final UsernameInput username;
  final PasswordInput password;
  final BusinessInput business;
  final LoadingStatus loaded;
  final bool isFormPosted;
  final bool isPosting;

  const LoginFormState({
    this.isFormPosted = false,
    this.isFormValid = false,
    this.formStatus = FormStatus.invalid,
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.business = const BusinessInput.pure(),
    this.loaded = LoadingStatus.initial,
    this.isPosting = false,
  });

  LoginFormState copyWith({
    bool? isFormValid,
    FormStatus? formStatus,
    UsernameInput? username,
    PasswordInput? password,
    BusinessInput? business,
    LoadingStatus? loaded,
    bool? isFormPosted,
    bool? isPosting,
  }) =>
      LoginFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        formStatus: formStatus ?? this.formStatus,
        username: username ?? this.username,
        password: password ?? this.password,
        business: business ?? this.business,
        loaded: loaded ?? this.loaded,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
      );
}
