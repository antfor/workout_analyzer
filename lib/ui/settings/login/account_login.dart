import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/state/user.dart';
import 'package:workout_analyzer/ui/components/focus_text_field.dart';
import 'package:workout_analyzer/ui/settings/login/password_field.dart';
import 'package:workout_analyzer/ui/util.dart' as util;


class AccountLogin extends ConsumerStatefulWidget {
  final String? error;

  const AccountLogin(this.error,{super.key});

  @override
  LoginState createState() {
    return LoginState();
  }
}

class LoginState extends ConsumerState<AccountLogin> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final accontHandler = ref.read(userProvider.notifier);

    final email = TextEditingController();
    final password = TextEditingController();

    final passwordField =  PasswordField(password);
    
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        children: [ 
          Align(
            alignment: Alignment.centerLeft,
            child: util.H2("Log in to back up your data:")),
          Row(
            spacing: 8,
            children: [
              Expanded(child:emailField(email, context)), 
              Expanded(child:passwordField)]),
          submit(accontHandler, email, password, context),
          ?loginError(widget.error, context),
        ],
      ),
    );
  }

  Widget? loginError(String? error, BuildContext context){
      
      if(error == null)return null;

      return SelectableText("Error: $error", style: TextStyle(color:  Theme.of(context).colorScheme.error));
  }

  Widget submit(UserNotifier accontHandler, TextEditingController email, TextEditingController password, BuildContext context){
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        signUp(accontHandler, email, password, context),
        logIn(accontHandler, email, password, context),
      ],
    ); 
  }

  Widget logIn(UserNotifier accontHandler, TextEditingController email, TextEditingController password, BuildContext context){
    return FilledButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          accontHandler.login(email.text, password.text, Login.logIn);
        }
      },
      child: const Text('Log in'),
    );
  }

  Widget signUp(UserNotifier accontHandler, TextEditingController email, TextEditingController password, BuildContext context){
    return FilledButton.tonal(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          accontHandler.login(email.text, password.text, Login.register);
        }
      },
      child: const Text('Register'),
    );
  }
}




Widget emailField(TextEditingController emailController, BuildContext context){

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  tf (FocusNode focus) => TextFormField(
    focusNode: focus,
    controller: emailController,
    autofillHints: const [AutofillHints.email],
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.emailAddress,
    autocorrect: false,
    enableSuggestions: false,

    decoration: InputDecoration(
      prefixIcon: Icon(focus.hasFocus ? Icons.email_rounded : Icons.email_outlined),
      prefixIconColor: prefixColor(context),
      labelText: 'Email',
    ),
    onSaved: (String? value) {
      // This optional block of code can be used to run
      // code when the user saves the form.
    },
    validator: (value) {
      final trimmed = value?.trim() ?? '';
      if (trimmed.isEmpty) return 'Email required';
      if (!emailRegex.hasMatch(trimmed)) return 'Enter a valid email';
      return null;
    }
  );

  return FocusAwareTextField(tf);
}