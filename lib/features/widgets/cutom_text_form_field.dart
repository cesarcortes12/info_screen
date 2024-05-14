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
    this.floatingLabelBehavior,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFFFFFFF)),
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
    );

    const borderRadius = Radius.circular(15);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: width,
        height: height ?? 60,
        // padding: const EdgeInsets.only(bottom: 0, top: 15),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 75, 90, 103), // Color del borde
            width: 0.5, // Ancho del borde
          ),
          color: colors ?? Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
              topRight: borderRadius),
          /*boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],*/
        ),
        child: TextFormField(
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
            floatingLabelBehavior: floatingLabelBehavior,
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
      ),
      Padding(
          padding: const EdgeInsets.only(top: 8.0),
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
