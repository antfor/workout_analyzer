import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/standards/standards.dart';

class SettingsState {
  final Sex sex;
  final double bodyweight;
  final String filePath;

  const SettingsState({
    this.sex = Sex.male,
    this.bodyweight = 75,
    this.filePath = 'assets/data/workout_data_new.csv',//'assets/data/test_workout_data.csv',
  });

  SettingsState copyWith({Sex? sex, double? bodyweight, String? filePath}) {
    return SettingsState(
      sex: sex ?? this.sex,
      bodyweight: bodyweight ?? this.bodyweight,
      filePath: filePath ?? this.filePath,
    );
  }
}


class SettingsNotifier extends Notifier<SettingsState> {

  @override SettingsState build() => const SettingsState();

  void setSex(Sex s) => state = state.copyWith(sex: s);
  void setBodyweight(double w) => state = state.copyWith(bodyweight: w);
  void setFilePath(String path) => state = state.copyWith(filePath: path);
}


final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);
