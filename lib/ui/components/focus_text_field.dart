import 'package:flutter/material.dart';


class FocusAwareTextField extends StatefulWidget {
  final TextFormField Function(FocusNode) textForm;

  const FocusAwareTextField(this.textForm,{super.key});

  @override
  FocusAwareTextFieldState createState() => FocusAwareTextFieldState();
}

class FocusAwareTextFieldState extends State<FocusAwareTextField> {
  final FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();
    node.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.textForm(node);
  }
}
