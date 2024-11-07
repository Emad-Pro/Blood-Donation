import 'package:flutter/material.dart';

class GlobalTextFormFiled extends StatelessWidget {
  const GlobalTextFormFiled(
      {super.key,
      this.lableText,
      this.isSecure,
      this.keyboardType,
      this.iconButton,
      this.textEditingController,
      this.validator,
      this.readOnly,
      this.maxLength,
      this.onTap});
  final String? lableText;
  final bool? isSecure;
  final TextInputType? keyboardType;
  final IconButton? iconButton;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Function()? onTap;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: onTap,
        validator: validator,
        maxLength: maxLength,
        controller: textEditingController,
        obscureText: isSecure ?? false,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
          labelStyle: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4)),
          suffixIcon: iconButton,
          suffixIconColor:
              Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          labelText: lableText,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
                width: 1,
                color:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 1,
            ),
          ),
        ));
  }
}
