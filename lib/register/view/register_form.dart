import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:school_app/login/view/login_page.dart';
import 'package:school_app/register/bloc/register_bloc.dart';

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('registration Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _FirstnameInput(),
            const Padding(padding: EdgeInsets.all(6)),
             _LastnameInput(),
            const Padding(padding: EdgeInsets.all(6)),
             _EmailInput(),
            const Padding(padding: EdgeInsets.all(6)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(6)),
            _ConfirmPasswordInput(),
            const Padding(padding: EdgeInsets.all(6)),
            _RegisterButton(),
                        const Padding(padding: EdgeInsets.all(6)),
            _SignInButton()
          ],
        ),
      ),
    );
  }
}


class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _FirstnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstname != current.firstname,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_firstnameInput_textField'),
          onChanged: (firstname) =>
              context.read<RegisterBloc>().add(RegisterFirstNameChanged(firstname)),
          decoration: InputDecoration(
            labelText: 'firstname',
            errorText: state.firstname.invalid ? 'invalid firstname' : null,
          ),
        );
      },
    );
  }
}
class _LastnameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastname != current.lastname,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_lastnameInput_textField'),
          onChanged: (lastname) =>
              context.read<RegisterBloc>().add(RegisterLastNameChanged(lastname)),
          decoration: InputDecoration(
            labelText: 'lastname',
            errorText: state.lastname.invalid ? 'invalid lastname' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<RegisterBloc>().add(RegisterPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.re_password != current.re_password,
      builder: (context, state) {
        return TextField(
          key: const Key('RegisterForm_re_passwordInput_textField'),
          onChanged: (re_password) =>
              context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(re_password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 're_password',
            errorText: state.re_password.invalid ? 'invalid re_password' : null,
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('registerForm_continue_raisedButton'),
                child: const Text('Register'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<RegisterBloc>().add(const RegisterSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}


class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text('You have an account?'),
        TextButton(
          child: const Text(
            'Sign In',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              LoginPage.route()
              );
          },
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
