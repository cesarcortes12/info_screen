import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantalla_informativa/config/theme/theme.dart';
import 'package:pantalla_informativa/features/car_management/infrastructure/repositories/car_management_repository_impl.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/car_management/car_management_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/presentation.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/workshop_list_screen.dart';
import 'package:pantalla_informativa/features/car_management/presentation/screens/login_screen.dart';
// ignore: depend_on_referenced_packages

void main() {
  final carOrderServiceRepositoryimpl = CarOrderServiceRepositoryimpl();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthCubit(),
    ),
    BlocProvider(
      create: (context) => LoginFormCubit(authCubit: context.read<AuthCubit>()),
    ),
    BlocProvider(
      create: (context) => CarManagementCubit(
          carOrderServiceRepositoryimpl: carOrderServiceRepositoryimpl),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Info Screen',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/infoScreen': (context) => InfoScreen(
              title: 'Pantalla Informativa',
            ),
        '/info': (context) => WorkshopListScreen(),
      },
    );
  }
}
