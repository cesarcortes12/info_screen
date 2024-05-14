import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:pantalla_informativa/features/widgets/custom_filled_button.dart';
import 'package:pantalla_informativa/features/widgets/cutom_text_form_field.dart';
//import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 815) {
                // Pantalla grande, mostrar en una fila
                return Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: const Image(
                          image: AssetImage(
                              'assets/images/vehiculo_frontal_derecha.jpg'),
                          width: 300,
                          height: 300,
                        ),
                      ),
                      const SizedBox(
                          width: 30), // Espacio entre la imagen y el formulario
                      Container(
                          width: 500,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: _LoginForm()),
                    ],
                  ),
                );
              } else {
                // Pantalla pequeña, mostrar en una columna
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      child: const Image(
                        image: AssetImage(
                            'assets/images/vehiculo_frontal_derecha.jpg'),
                        width: 170,
                        height: 170,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: _LoginForm()),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final loginFormBloc = context.read<LoginCubit>();
    final scaffoldKey = ScaffoldMessenger.of(context);

    return BlocListener<AuthCubit, AuthState>(listener: (context, state) {
      print('errorMessage ${state.errorMessage}');
      if (state.errorMessage != '') {
        scaffoldKey.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            state.errorMessage,
          ),
        ));
      }
    }, child: BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return //SingleChildScrollView(
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Inicio de Sesión',
              style: textStyles.headlineSmall!.copyWith(
                  color: Color(0xFF27499b), fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Nombre de usuario',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => loginFormBloc.usernameChanged(value),
              errorMessage: loginFormBloc.state.username.errorMenssage,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              label: 'Contraseña',
              obscureText: true,
              onChanged: (value) => loginFormBloc.passwordChanged(value),
              errorMessage: loginFormBloc.state.password.errorMenssage,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomFilledButton(
                text: 'Ingresar',
                onPressed: () async {
                  //GoRouter.of(context).go('/');
                  Navigator.pushNamed(context, '/info');

                  if (!loginFormBloc.state.isPosting) {
                    loginFormBloc.onSumit();
                  }
                },
              ),
            ),
            // const Spacer(flex: 1),
            // const Spacer(flex: 1),
          ],
        );
        //);
      },
    ));
  }
}
