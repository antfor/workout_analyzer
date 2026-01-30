
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/domain.dart';
import 'package:test_flutter/domain/standards/muscle_group.dart';
import 'package:test_flutter/domain/standards/standards.dart';
import 'package:test_flutter/repository/import.dart';

final domainProvider = FutureProvider.family<Domain, DomainArgs>((ref, args) async {

  return await importDataFromCsv(args.muscles, args.male, args.female, args.filePath);
});

class DomainArgs {
  final Map<String, Muscle> muscles;
  final Standards male;
  final Standards female;
  final String filePath;
  
  const DomainArgs(this.muscles, this.male, this.female, this.filePath);

  @override bool operator ==(Object other) => 
    identical(this, other) || other is DomainArgs && other.filePath == filePath;

  @override 
  int get hashCode => Object.hash(muscles, male, female, filePath);
}
