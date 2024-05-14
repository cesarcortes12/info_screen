import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:pantalla_informativa/features/car_management/domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState()) {
    checkAuthStatus();
  }

  AuthStatus get authStatus => state.authStatus;

  Future<void> loginUser(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      //final User? user =
      //await authRepository.login(bussines, username, password);
      //_setLoggedUser(user);
    } on CustomError catch (e) {
      emit(state.copyWith(errorMessage: e.message));
      logout(e.message);
    } on Exception catch (e) {
      emit(state.copyWith(errorMessage: ' ${e.toString()}'));
    }
  }

  void checkAuthStatus() async {
    //final token = await keyValueStorageService.loadToken();

    //if (token == null) return logout();
    //final userJson = await keyValueStorageService.getValue<String>('user');

    //final user = userJson != null ? User.fromJson(jsonDecode(userJson)) : null;

    try {
      //_setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User? user) async {
    //await keyValueStorageService.saveToken(user?.token ?? '');
    //await keyValueStorageService.saveUser(user);

    emit(state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    ));
  }

  Future<void> logout([String? errorMessage]) async {
    //await keyValueStorageService.removeKey('token');

    emit(state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage ?? '',
    ));
  }
}

class CustomError implements Exception {
  final String message;

  // final int errorCode;
  CustomError(this.message);
  @override
  String toString() => message;
}
