import 'package:formz/formz.dart';

enum PasswordInputError { empty }

// Extend FormzInput and provide the input type and error type.
class PasswordInput extends FormzInput<String, PasswordInputError> {
  // Call super.pure to represent an unmodified form input.
  const PasswordInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);
  String? get errorMenssage {
    if (isValid || isPure) return null;
    if (displayError == PasswordInputError.empty) {
      return 'Contraseña es requerido';
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PasswordInputError.empty;
    return null;
  }
}
