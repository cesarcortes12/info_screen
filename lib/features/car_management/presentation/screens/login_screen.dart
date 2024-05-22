import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:pantalla_informativa/features/car_management/presentation/cubit/login_form_cubit/login_form_cubit.dart';
import 'package:pantalla_informativa/features/widgets/custom_filled_button.dart';
import 'package:pantalla_informativa/features/widgets/cutom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 815) {
                return Container(
                  margin: EdgeInsets.only(top: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(vertical: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/taller.jpg'),
                            width: 500,
                            height: 500,
                          ),
                        ),
                      ),
                      Container(
                          width: 500,
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: _LoginForm()),
                    ],
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
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
    final loginFormCubit = context.read<LoginFormCubit>();
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
    }, child:
        BlocBuilder<LoginFormCubit, LoginFormState>(builder: (context, state) {
      return Column(
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
            label: 'Empresa',
            keyboardType: TextInputType.text,
            onChanged: (value) => loginFormCubit.businessChanged(value),
            errorMessage: loginFormCubit.state.business.errorMenssage,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombre de usuario',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginFormCubit.usernameChanged(value),
            errorMessage: loginFormCubit.state.username.errorMenssage,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (value) => loginFormCubit.passwordChanged(value),
            errorMessage: loginFormCubit.state.password.errorMenssage,
          ),
          const SizedBox(height: 10),
          BlocBuilder<LoginFormCubit, LoginFormState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomFilledButton(
                  text: loginFormCubit.state.loaded == LoadingStatus.checking
                      ? const CircularProgressIndicator(strokeWidth: 4)
                      : Text('INICIAR SESION'),
                  onPressed: () async {
                    await loginFormCubit.onSumit();
                  },
                ),
              );
            },
          ),
        ],
      );
    }));
  }
}
