import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({
    super.key,
    required this.keyName,
    required this.name,
    required this.label,
    required this.hintText,
  });

  final String keyName;
  final String name;
  final String label;
  final String hintText;

  @override
  State<PasswordFieldWidget> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordFieldWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FormBuilderTextField(
      obscureText: _obscureText,
      name: widget.name,
      key: Key(widget.keyName),
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: widget.label,
        icon: const Icon(Icons.lock_outline),
        hintText: widget.hintText,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: theme.colorScheme.primary,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? "Campo requerido" : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
