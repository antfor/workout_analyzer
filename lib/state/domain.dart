
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/domain.dart';
import 'package:workout_analyzer/repository/repo.dart';


class DomainNotifier extends AsyncNotifier<Domain?> {

  @override Future<Domain?> build() async => ref.read(repoProvider)?.getDomain();


  Future<void> setDomain(Domain? d) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => d);
  }

  Future<void> importDomain(String filePath) async {
    final repo = ref.read(repoProvider);
    if (repo == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final current = state.value;
      return repo.importCSV(filePath, current);
    });
  }
}


final domainProvider = AsyncNotifierProvider<DomainNotifier, Domain?>(DomainNotifier.new);


