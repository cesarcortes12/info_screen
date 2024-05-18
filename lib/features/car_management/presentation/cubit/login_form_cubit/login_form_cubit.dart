import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/shared/inputs/business.dart';
import 'package:pantalla_informativa/features/shared/inputs/password.dart';
import 'package:pantalla_informativa/features/shared/inputs/userName.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  final AuthCubit authCubit;
  LoginFormCubit({required this.authCubit}) : super(const LoginFormState());

  Future<void> onSumit() async {
    _validatingstate();
    print('STATE ${state}');
    if (!state.isFormValid) return;
    emit(state.copyWith(formStatus: FormStatus.posting));
    emit(state.copyWith(loaded: LoadingStatus.checking));

    await authCubit.loginUser(
        state.business.value, state.username.value, state.password.value);

    emit(state.copyWith(loaded: LoadingStatus.success));
  }

  _validatingstate() {
    emit(state.copyWith(
      formStatus: FormStatus.validating,
      username: UsernameInput.dirty(value: state.username.value),
      password: PasswordInput.dirty(value: state.password.value),
      business: BusinessInput.dirty(value: state.business.value),
      isFormValid:
          Formz.validate([state.business, state.username, state.password]),
    ));
  }

  void usernameChanged(String username) {
    final usernameInput = UsernameInput.dirty(value: username);
    emit(state.copyWith(
        username: usernameInput, isFormValid: Formz.validate([usernameInput])));
  }

  void passwordChanged(String password) {
    final passwordInput = PasswordInput.dirty(value: password);
    emit(state.copyWith(
        password: passwordInput, isFormValid: Formz.validate([passwordInput])));
  }

  void businessChanged(String business) {
    final businessInput = BusinessInput.dirty(value: business);
    emit(state.copyWith(
        business: businessInput, isFormValid: Formz.validate([businessInput])));
  }

  void reset() {
    emit(const LoginFormState());
  }
}
