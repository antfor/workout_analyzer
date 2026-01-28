import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_flutter/domain/standards/standards.dart';

class _SettingsState {
  final Sex sex;
  final double bodyweight;
  final String filePath;

  const _SettingsState({
    this.sex = Sex.male,
    this.bodyweight = 75,
    this.filePath = '',
  });

  _SettingsState copyWith({Sex? sex, double? bodyweight, String? filePath}) {
    return _SettingsState(
      sex: sex ?? this.sex,
      bodyweight: bodyweight ?? this.bodyweight,
      filePath: filePath ?? this.filePath,
    );
  }
}


class _SettingsNotifier extends Notifier<_SettingsState> {

  @override _SettingsState build() => const _SettingsState();

  void setSex(Sex s) => state = state.copyWith(sex: s);
  void setBodyweight(double w) => state = state.copyWith(bodyweight: w);
  void setFilePath(String path) => state = state.copyWith(filePath: path);
}


final settingsProvider = NotifierProvider<_SettingsNotifier, _SettingsState>(_SettingsNotifier.new);
