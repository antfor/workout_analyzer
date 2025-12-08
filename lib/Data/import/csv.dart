import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

//todo move folder into Repoitory  (private package there)

Future<List<List<dynamic>>> loadCsv(String filePath) async {
  final rawData = await rootBundle.loadString(filePath);
  List<List<dynamic>> rows = const CsvToListConverter(eol: '\n').convert(rawData);

  return rows;
}