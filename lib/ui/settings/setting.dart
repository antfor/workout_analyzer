import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/state/settings.dart';
import 'package:test_flutter/ui/util.dart' as util;


class Settings extends ConsumerWidget {

  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => _bottomSheet(context, ref),
    );
  }

  void _bottomSheet(BuildContext context, WidgetRef ref){

    final List<DropdownMenuEntry<Sex>> sexEntries = Sex.values.map((s)=>
      DropdownMenuEntry<Sex>( value: s, label: s.string)
    ).toList();

    showModalBottomSheet(
      context: context,
      showDragHandle: true,

      builder: (sheetContext) => Consumer(builder: (c, sheetRef, _){
        final settings = sheetRef.watch(settingsProvider);
        final editSettings = sheetRef.read(settingsProvider.notifier);
        return Padding( padding: EdgeInsets.all(16),
        child: util.dropdown<Sex>(
          selection: settings.sex,
          onSelected: (s) { 
            if (s != null) { 
              editSettings.setSex(s); 
            } 
          },
          entries: sexEntries,
          label: (T) => T == null ? "" : T.string,
          ),
      );
    })
    );
  }
 
}