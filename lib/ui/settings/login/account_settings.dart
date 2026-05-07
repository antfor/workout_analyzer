import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workout_analyzer/state/user.dart';
import 'package:workout_analyzer/ui/settings/login/account_login.dart';
import 'package:workout_analyzer/ui/util.dart' as util;


class AccountSettings extends ConsumerWidget{
  
  const AccountSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final asyncAuthResult = ref.watch(userProvider);
    final handleUser = ref.read(userProvider.notifier);
    
    return asyncAuthResult.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
      data: (authResult) {

        final user = authResult.user;

        if(user == null){
          return AccountLogin(authResult.error);
        }else{
          return logout(user, handleUser);
        }
    });
  }
}

Widget logout(User user, UserNotifier accontHandler){
  return Row(
    spacing: 16,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      util.H3("Logged in as: ${user.email??user.id}"),
      FilledButton.tonal(
        onPressed: accontHandler.logout,
        child: const Text('Log out'),
      ),
      ]
  );
}