import 'package:formz/formz.dart';

enum UsernameInputError { empty }

// Extend FormzInput and provide the input type and error type.
class UsernameInput extends FormzInput<String, UsernameInputError> {
  // Call super.pure to represent an unmodified form input.
  const UsernameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);
  String? get errorMenssage {
    if (isValid || isPure) return null;
    if (displayError == UsernameInputError.empty) {
      return 'Usuario es requerido';
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UsernameInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsernameInputError.empty;
    return null;
  }
}
