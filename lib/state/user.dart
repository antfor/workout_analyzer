import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workout_analyzer/repository/repo.dart';


enum Login{
  logIn,
  register
}

class UserNotifier extends AsyncNotifier<AuthResult> {

  @override AuthResult build() => 
    ref.read(repoProvider)?.getUser() ?? AuthResult(error:"no repo");


  Future<void> login(String email, String password, Login login) async {
    final repo = ref.read(repoProvider);
    if (repo == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      switch (login){
        case Login.logIn: return repo.logIn(email, password);
        case Login.register: return repo.register(email, password);
      }
    });
  }

  Future<void> logout() async {
    final repo = ref.read(repoProvider);
    if (repo == null) return;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return repo.logOut();
    });
  }
}


final userProvider = AsyncNotifierProvider<UserNotifier, AuthResult>(UserNotifier.new);


