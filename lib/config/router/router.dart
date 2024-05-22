import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantalla_informativa/features/car_management/presentation/presentation.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
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
    GoRoute(
      path: '/info/:idWarehouse',
      builder: (context, state) {
        final String idWarehouse = state.pathParameters['idWarehouse'] ?? '';
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            return InfoScreen(idWarehouse: idWarehouse);
          },
        );
      },
    ),
  ],
);
