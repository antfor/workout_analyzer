import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/domain/standards/standards.dart';

class SettingsState {
  final Sex sex;
  final double bodyweight;

  const SettingsState({
    this.sex = Sex.male,
    this.bodyweight = 75,
  });

  SettingsState copyWith({Sex? sex, double? bodyweight, String? filePath}) {
    return SettingsState(
      sex: sex ?? this.sex,
      bodyweight: bodyweight ?? this.bodyweight,
    );
  }
}


class SettingsNotifier extends Notifier<SettingsState> {

  @override SettingsState build() => const SettingsState();

  void setSex(Sex s) => state = state.copyWith(sex: s);
  void setBodyweight(double w) => state = state.copyWith(bodyweight: w);
}


final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);
