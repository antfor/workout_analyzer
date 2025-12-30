import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

const int desktop = 1024;
const int tablet = 700;

  double _roundTo(double n, [int d = 0]) {
    final pow = math.pow(10, d);
    return (n * pow).round() / pow;
  }

  String simplifyValue(double value, int decimals) {
    final rounded = _roundTo(value, decimals);

    return NumberFormat.decimalPattern('en_US').format(rounded + 0);
  }

class H1 extends StatelessWidget{

  final String text;

  const H1(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineLarge);
  }
}

class H2 extends StatelessWidget{

  final String text;

  const H2(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineMedium);
  }
}

class H3 extends StatelessWidget{

  final String text;

  const H3(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall);
  }
}


Widget dropdown<T>({required List<DropdownMenuEntry<T>> entries, T? selection, String? hintText, double? menuHeight, void Function(T?)? onSelected,required String Function(T?) label }){
  
  final controller = TextEditingController(text: label(selection));
  
  return DropdownMenu(
    initialSelection: selection,
    requestFocusOnTap: false,
    controller: controller,
    hintText: hintText,
    menuHeight: menuHeight,
    onSelected:(value) => onSelected == null ? null : onSelected(value),
    dropdownMenuEntries:  entries
  );
}