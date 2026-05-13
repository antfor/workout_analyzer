
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import 'package:workout_analyzer/repository/repo.dart';


class DomainNotifier extends AsyncNotifier<Domain?> {

  @override Future<Domain?> build() async => ref.read(repoProvider)?.getDomain();


  Future<void> setDomain(Domain? d) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => d);
  }

  Future<String?> importDomain(Uint8List data) async {
    final repo = ref.read(repoProvider);
    if (repo == null) return "Error: No Repo";

    final oldDomain = state.value;
    state = const AsyncLoading();
    String? error;

    state = await AsyncValue.guard(() async {
      final result = await repo.importCSV(data, oldDomain);
      final domain = result.result;
      error = result.error;
    
      if(domain != null){
        return domain;
      }

      return oldDomain;
    });

    return error;
  }
}


final domainProvider = AsyncNotifierProvider<DomainNotifier, Domain?>(DomainNotifier.new);


