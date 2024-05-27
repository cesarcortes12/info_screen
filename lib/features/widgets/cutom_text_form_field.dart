import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final bool readOnly;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Key? keyId;
  final int maxLine;
  final TextEditingController? controller;
  final onTap;
  final Color? colors;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final double? height;
  final double? width;

  const CustomTextFormField({
    super.key,
    this.maxLine = 1,
    this.keyId,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.onFieldSubmitted,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.colors,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    final border = OutlineInputBorder(
      //borderSide: BorderSide(color: Color(0xFFFFFFFF)),
      borderRadius: BorderRadius.circular(20),
    );

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextFormField(
        readOnly: readOnly,
        onTap: onTap,
        controller: controller,
        maxLines: maxLine,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0.8, horizontal: 10),
          floatingLabelBehavior: floatingLabelBehavior,
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            height: 4.0,
          ),
          //floatingLabelStyle: const TextStyle(
          //  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          border: border,
          errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          label: label != null ? Text(label!) : null,
          hintText: hint ?? '',
          //hintText: hint,
          //labelStyle: textStyle,
          //errorText: errorMessage,
          //focusColor: colors.primary,
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Container(
            //margin: EdgeInsets.only(right: 40.0),
            child: errorMessage != null
                ? Text(
                    errorMessage!,
                    style: textStyles.bodyMedium!.copyWith(
                      color: const Color.fromARGB(255, 238, 81, 53),
                    ),
                  )
                : null,
          )),
    ]);
  }
}
