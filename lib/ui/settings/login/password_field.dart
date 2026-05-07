import 'package:flutter/material.dart';
import 'package:workout_analyzer/ui/components/focus_text_field.dart';

class PasswordField extends StatefulWidget {

  final TextEditingController passwordController;

  const PasswordField(this.passwordController, {super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {

    tf(FocusNode focus) => TextFormField(
      focusNode: focus,
      controller: widget.passwordController,
      obscureText: !isVisible,
      autofillHints: const [AutofillHints.password],
      enableSuggestions: false,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIconColor: prefixColor(context),
        prefixIcon: Icon(focus.hasFocus ? Icons.lock_rounded : Icons.lock_outlined),
        labelText: 'Password',
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Password required';
        if (value.length < 6) return 'At least 6 characters';
        return null;
      },
    );

    return FocusAwareTextField(tf);
  }
}


WidgetStateColor prefixColor(BuildContext context){
  return WidgetStateColor.resolveWith((states) {
    if (states.contains(WidgetState.error)) {
      return Theme.of(context).colorScheme.error;
    }
    if (states.contains(WidgetState.focused)) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.onSurfaceVariant;
  }); 
}