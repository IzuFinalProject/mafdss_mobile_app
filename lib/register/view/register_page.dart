import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/login/bloc/login_bloc.dart';
import 'package:school_app/register/bloc/register_bloc.dart';

import 'register_form.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Register')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: BlocProvider(
              create: (context) {
                return RegisterBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                );
              },
              child: RegisterForm(),
            ),
          ),
        ));
  }
}
