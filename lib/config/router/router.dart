import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/login_screen.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/workshop_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        //return const LoginScreen();

        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState.authStatus == AuthStatus.authenticated) {
              return const WorkshopListScreen();
            } else {
              return const LoginScreen();
            }
          },
        );
      },
    ),
  ],
);
