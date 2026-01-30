import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/state/settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:test_flutter/ui/util.dart' as util;


class Settings extends StatelessWidget {

  const Settings({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding( padding: EdgeInsets.symmetric(horizontal: 8),
        child:IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => _bottomSheet(context),
    ));
  }

  void _bottomSheet(BuildContext context){

    final List<DropdownMenuEntry<Sex>> sexEntries = Sex.values.map((s)=>
      DropdownMenuEntry<Sex>( value: s, label: s.string)
    ).toList();

    showModalBottomSheet(
      context: context,
      showDragHandle: true,

      builder: (sheetContext) => Consumer(builder: (c, ref, _){

        final settings = ref.watch(settingsProvider);
        final editSettings = ref.read(settingsProvider.notifier);

        return Padding( padding: EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          children: [ 
          importData(ref),
          util.dropdown<Sex>(
            selection: settings.sex,
            onSelected: (s) { 
              if (s != null) { 
                editSettings.setSex(s); 
              } 
            },
            entries: sexEntries,
            label: (T) => T == null ? "" : T.string,
            ),
          ],)
        );
    })
    );
  }
 
}

Widget importData(WidgetRef ref){

  final editSettings = ref.read(settingsProvider.notifier);

  void pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if(result != null && result.files.single.path != null ){
      final String path = result.files.single.path!;
      
      editSettings.setFilePath(path);
    }
  }

  return FilledButton(
    onPressed: pickFile, 
    child: const Text('Import Data'));

}