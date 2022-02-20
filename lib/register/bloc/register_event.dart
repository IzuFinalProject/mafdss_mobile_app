part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterFirstNameChanged extends RegisterEvent {
  const RegisterFirstNameChanged(this.firstname);

  final String firstname;

  @override
  List<Object> get props => [firstname];
}
class RegisterLastNameChanged extends RegisterEvent {
  const RegisterLastNameChanged(this.lastname);

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}
class RegisterConfirmPasswordChanged extends RegisterEvent {
  const RegisterConfirmPasswordChanged(this.re_password);

  final String re_password;

  @override
  List<Object> get props => [re_password];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
