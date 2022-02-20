import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { empty,mismatch }

class ConfirmPassword extends FormzInput<String, ConfirmPasswordValidationError> {
    final String password;
  const ConfirmPassword.pure({
    this.password = ''
  }) : super.pure('');
  const ConfirmPassword.dirty({
    required this.password,
    String value = ''
  }) : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String? value) {
     if ( value?.isEmpty == true) {
       return ConfirmPasswordValidationError.empty;
     }
    return password == value ? null: ConfirmPasswordValidationError.mismatch;
  }
}

extension Explanation on ConfirmPasswordValidationError {
  String? get name {
    switch(this) {
      case ConfirmPasswordValidationError.mismatch:
        return 'passwords must match';
      default:
        return null;
    }
  }
}
