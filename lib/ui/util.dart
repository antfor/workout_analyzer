import 'package:flutter/material.dart';

const int desktop = 1024;
const int tablet = 700;


final spectrum  = spectrumN(5);
//#e6e7e8 <- color of empty muscle

List<Color> spectrumN2 (int n) => List.generate(n, (i) => Color.fromARGB(255, 255, (255/n).floor()*(n-i-1),0));
List<Color> spectrumN(int n) => List.generate(n, (i) {
  if(n <= 1){
    return Color.fromARGB(255, 255, 0, 0);
  }

  final g = ((255/(n-1))*(n-i-1)).round();
  final b = ((n-i-1)* 75/n).round();
  final r = (215 + 50/n * i).round();

  return Color.fromARGB(255, r, g, b);
});

//TODO move to componets
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