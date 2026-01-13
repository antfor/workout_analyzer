import 'package:flutter/material.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/util.dart';

class StrengthLevel extends StatefulWidget{

  final Standard standard;
  final double realBodyWeight;
  final double orm;

  const StrengthLevel(this.standard, this.realBodyWeight, this.orm, {super.key});

  
  @override
  State<StatefulWidget> createState() => _StrengthLevel();
}

class _StrengthLevel extends State<StrengthLevel>{

  double? bodyWeight;



  @override
  Widget build(BuildContext context) {
    final bw = bodyWeight ?? widget.realBodyWeight;
    final level = _strengthLevel(widget.standard, bw, widget.orm);
    final standard = widget.standard.weight ??  widget.standard.reps;
    setWeight(bw) => setState(() => bodyWeight = bw);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
      if(level != null && standard != null) H3('Strenght Level'),
      if(level != null && standard != null) level,
      if(level != null && standard != null) Align(alignment: AlignmentGeometry.centerRight, 
          child:dropdownWeight(bodyWeight, widget.realBodyWeight, standard.bodyweight, setWeight)),
    ],);
  }

}

Widget dropdownWeight(double? bodyWeight, double realBw, Iterable<int> bws, void Function(double?) setWeight){

  final controller = TextEditingController(text:'${bodyWeight ?? realBw} kg');

  return DropdownMenu<double>(
              controller: controller,
              requestFocusOnTap: false, // prevents keyboard from opening
              onSelected: (value) {
                //controller.text = '$value kg'; 
                setWeight(value);
              },
              initialSelection: realBw,
              menuHeight: 200,
              dropdownMenuEntries: entries([realBw, ...bws.map((i)=>i.toDouble())]),
            );
}

List<DropdownMenuEntry<T>> entries<T extends num>(List<T> list){
  
    return list.map((m) => DropdownMenuEntry<T>(
                  value: m,
                  label:'$m kg',
                )).toList();
}

Widget? _strengthLevel(Standard standard, double bodyWeight, double orm){
  
  final table = standard.weight ?? standard.reps;

  if(table == null){
    return Text('');
  }

  int index = table.bodyweight.toList().lastIndexWhere((i) => i <= bodyWeight);
  index = index == -1 ? 0 : index;
  final bwStandard = table.standrads(index);

  bar(double v, String level, String weight, Color c1, Color c2) => Expanded(child:
    Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children:[Text(level, maxLines: 1, overflow: TextOverflow.ellipsis),
      GradientProgressBar(value: v, startColor:c1, endColor: c2), 
      Text(weight,maxLines: 1, overflow: TextOverflow.ellipsis)],));

  final spectrum = List.generate(5, (i) => Color.fromARGB(255, 255, 63*(4-i), 0));
  final List<Widget> bars = [];
  bool belowLevel = true;
  for(int i = 0; i < bwStandard.length; i++ ){
    final weight = bwStandard[i];
    final next = i+1 < bwStandard.length ? bwStandard[i+1] : bwStandard[i] / Level.elite.percentage;
    final level = Level.byIndex(i).label;
    final limit = '$weight kg';
    final c1 = i > spectrum.length-1? spectrum.last :spectrum[i];
    final c2 = i >= spectrum.length-1? c1 : spectrum[i+1];

    if(next <= orm){
      bars.add(bar(1, level, limit, c1, c2));
    }else if(belowLevel){
      bars.add(bar((orm-weight)/(next-weight), level, limit, c1, c2)); //TODO orm or max reps
      belowLevel=false;
    }else{
      bars.add(bar(0, level, limit, c1, c2));
    }
  }
  return Row(spacing: 3, children: bars,);
}


class GradientProgressBar extends StatelessWidget {
  final double value;
  final Color startColor;
  final Color endColor;
  final double height;
  final Widget? headline;

  const GradientProgressBar({
    required this.value,
    required this.startColor,
    required this.endColor,
    this.height = 10,
    this.headline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children:[
        if(headline != null) headline!,
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 4),
          child: Stack(
            children: [
              Container(
                height: height,
                color: scheme.surfaceContainerHighest,
              ),

              FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [startColor, endColor],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]);
  }
}
