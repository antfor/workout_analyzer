import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

//todo move folder into Repoitory  (private package there)

Future<List<List<dynamic>>> loadCsv(String filePath) async {
  final rawData = await rootBundle.loadString(filePath);
  final List<List<dynamic>> rows = csv.decoder.convert(rawData);
  return rows;
}

Future<List<List<dynamic>>> loadCsvBytes(Uint8List bytes) async {

  String csvString = utf8.decode(bytes);

  return csv.decoder.convert(csvString);
}