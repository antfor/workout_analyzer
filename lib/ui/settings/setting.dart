import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/state/domain.dart';
import 'package:workout_analyzer/ui/settings/login/account_settings.dart';
import '/domain/standards/standards.dart';
import '/state/settings.dart';
import 'package:file_picker/file_picker.dart';
import '/ui/util.dart' as util;


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
          AccountSettings(), //TODO create logout widget if logged in
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

  final notifier = ref.read(domainProvider.notifier);

  Future<void> pickFile() async{
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['csv'],
        withData: true, 
      );

      final file = result?.files.first;
      
      if (file?.bytes case final data?) {
        notifier.importDomain(data);
      }
    } catch (e) {
    debugPrint('File pick failed: $e');
  }
  }

  return OutlinedButton(
    onPressed: pickFile, 
    child: const Text('Import Data'));

}