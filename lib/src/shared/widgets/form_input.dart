import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.label,
    required this.type,
    required this.validator,
    required this.onSaved,
    this.maxLength,
    this.value,
    this.prefix,
    this.readOnly = false,
    this.isRequired = false,
  });

  final String label;
  final TextInputType type;
  final String? value;

  final Function(String? value) validator;
  final Function(String? value) onSaved;
  final String? prefix;
  final int? maxLength;
  final bool? readOnly;
  final bool? isRequired;

  Widget inputLable(bool isRequired, String label) {
    if (isRequired) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      );
    }
    return Text(label);
  }

  @override
  Widget build(context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      initialValue: value,
      maxLength: maxLength,
      keyboardType: type,
      decoration: InputDecoration(
        filled: readOnly ?? false,
        fillColor: Colors.grey[200],
        label: inputLable(isRequired!, label),
        prefix: (prefix != null) ? Text(prefix.toString()) : const Text(""),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.error,
                style: BorderStyle.solid)),
      ),
      validator: (value) {
        return validator(value);
      },
      onSaved: (value) {
        if (value!.isNotEmpty) {
          onSaved(value);
        }
      },
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
