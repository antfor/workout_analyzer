import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/ui/util.dart';

final double bodyWeight = 75;
final sex = Sex.male;

class Summary extends StatelessWidget {

  const Summary({super.key});

  @override
  Widget build(BuildContext context) {

    final maxWidth = const BoxConstraints(maxWidth: 400);
    final padding = EdgeInsetsGeometry.symmetric(vertical: 8, horizontal: 16);
    pad(w) => Container(padding:padding , child: w,);
    constrain(w) => Center(child:Container(constraints: maxWidth, padding: padding, child:w));
    
    return ListView(children: [
      constrain(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          H2("Muscle chart"),
          svg,
        ],)),
    ]);

  }
}

/*
	.s0 { fill: #808284 } 
		.s1 { fill: #bbbdbf } 
		.s2 { fill: #ec1c24 } 
		.s3 { fill: #e6e7e8 } 
*/

class _MyColorMapper extends ColorMapper {
  const _MyColorMapper();

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color,) {
      
    if(id == "calves"){
      return Color(0xFFFF0000);
    }
        
    return color;
  }
}

  final Widget svg = FittedBox(child: 
    SvgPicture.asset(
      'assets/images/man.svg',
      fit: BoxFit.contain,
      semanticsLabel: 'Man',
      colorMapper: const _MyColorMapper(),
  ));
