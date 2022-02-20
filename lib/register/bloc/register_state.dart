part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.firstname = const FirstName.pure(),
    this.lastname = const LastName.pure(),
    this.re_password = const ConfirmPassword.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Email email;
  final FirstName firstname;
  final LastName lastname;
   final Password password;
  final ConfirmPassword re_password;
 
  RegisterState copyWith({
    FormzStatus? status,
    Email? email,
    FirstName? firstname,
    LastName? lastname,
    Password? password,
    ConfirmPassword? re_password,
  }) {
    return RegisterState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      re_password: re_password ?? this.re_password,
    );
  }

  @override
  List<Object> get props => [status, firstname,lastname,email, password,re_password];
}
