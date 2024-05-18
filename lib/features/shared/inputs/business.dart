import 'package:formz/formz.dart';

enum BusinessInputError { empty }

// Extend FormzInput and provide the input type and error type.
class BusinessInput extends FormzInput<String, BusinessInputError> {
  // Call super.pure to represent an unmodified form input.
  const BusinessInput.pure() : super.pure('');

  // Call super.dirty to represent a modifeied form input.
  const BusinessInput.dirty({String value = ''}) : super.dirty(value);

  String? get errorMenssage {
    if (isValid || isPure) return null;
    if (displayError == BusinessInputError.empty) {
      return 'Empresa es requerido';
    }
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  BusinessInputError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return BusinessInputError.empty;
    return null;
  }
}
