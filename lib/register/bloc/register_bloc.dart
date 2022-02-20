import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:school_app/register/models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterFirstNameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.firstname,
        state.lastname,
        state.password,
        state.re_password,
        email
      ]),
    ));
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.firstname,
        state.email,
        state.lastname,
        state.re_password,
        password
      ]),
    ));
  }

  void _onConfirmPasswordChanged(
    RegisterConfirmPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final re_password = ConfirmPassword.dirty( password: state.password.value,value: event.re_password);
    emit(state.copyWith(
      re_password: re_password,
      status: Formz.validate([
        state.firstname,
        state.email,
        state.lastname,
        state.password,
        re_password
      ]),
    ));
  }

  void _onFirstNameChanged(
    RegisterFirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final firstname = FirstName.dirty(event.firstname);
    emit(state.copyWith(
      firstname: firstname,
      status: Formz.validate([
        firstname,
        state.email,
        state.lastname,
        state.re_password,
        state.password
      ]),
    ));
  }

  void _onLastNameChanged(
    RegisterLastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final lastname = LastName.dirty(event.lastname);
    emit(state.copyWith(
      lastname: lastname,
      status: Formz.validate([
        lastname,
        state.email,
        state.firstname,
        state.re_password,
        state.password
      ]),
    ));
  }

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.register(
          email: state.email.value,
          firstname: state.firstname.value,
          lastname: state.lastname.value,
          re_password: state.re_password.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
