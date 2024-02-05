import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
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
    this.isObscure = false,
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
  final bool isObscure;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  late bool isVisible;

  @override
  void initState() {
    isVisible = widget.isObscure;
    super.initState();
  }

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
      obscureText: isVisible,
      readOnly: widget.readOnly ?? false,
      initialValue: widget.value,
      maxLength: widget.maxLength,
      keyboardType: widget.type,
      decoration: InputDecoration(
        suffixIcon: (widget.isObscure)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon:
                    Icon((isVisible) ? Icons.visibility_off : Icons.visibility))
            : null,
        filled: widget.readOnly ?? false,
        fillColor: Colors.grey[200],
        label: inputLable(widget.isRequired!, widget.label),
        prefix: (widget.prefix != null)
            ? Text(widget.prefix.toString())
            : const Text(""),
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
        return widget.validator(value);
      },
      onSaved: (value) {
        if (value!.isNotEmpty) {
          widget.onSaved(value);
        }
      },
      style: Theme.of(context).textTheme.labelLarge,
    );
  }
}
