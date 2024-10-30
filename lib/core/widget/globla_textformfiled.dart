import 'package:flutter/material.dart';

class GlobalTextFormFiled extends StatelessWidget {
  const GlobalTextFormFiled({
    super.key,
    this.lableText,
    this.isSecure,
    this.keyboardType,
    this.iconButton,
    this.textEditingController,
    this.validator,
  });
  final String? lableText;
  final bool? isSecure;
  final TextInputType? keyboardType;
  final IconButton? iconButton;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: textEditingController,
        obscureText: isSecure ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
          suffixIcon: iconButton,
          labelText: lableText,
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
        ));
  }
}
