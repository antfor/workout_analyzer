import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

//todo move folder into Repoitory  (private package there)

Future<List<List<dynamic>>> loadCsv(String filePath) async {
  final rawData = await rootBundle.loadString(filePath);
  final List<List<dynamic>> rows = csv.decoder.convert(rawData);
  return rows;
}