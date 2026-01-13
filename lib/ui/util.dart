import 'package:flutter/material.dart';

const int desktop = 1024;
const int tablet = 700;

final spectrum = List.generate(5, (i) => Color.fromARGB(255, 255, 63*(4-i), 0));

Color strengthColor(double level) {
  level = level.clamp(0.0, 5.0);

  // Below beginner
  if (level < 1.0) {
    return const Color(0xFF9E9E9E); // neutral gray
  }

  // Normalize [1 → 5] to [0 → 1]
  final t = (level - 1.0) / 4.0;

  // Blue → Red
  final double hue = 210 * (1.0 - t);

  // Slight lightness boost for advanced users
  final double lightness = 0.45 + (0.08 * t);

  return HSLColor.fromAHSL(
    1.0,        // alpha
    hue,        // hue
    0.85,       // saturation
    lightness,       // lightness
  ).toColor();
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