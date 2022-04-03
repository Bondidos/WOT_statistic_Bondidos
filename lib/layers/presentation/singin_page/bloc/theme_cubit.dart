import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:wot_statistic/layers/domain/usecases/sync_theme_usecase.dart';

import '../../../../common/constants/constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SyncThemeUseCase sync;

//todo get default theme from android

  ThemeCubit({required this.sync}) : super(ThemeInit()) {
    _syncTheme();
  }

  void _syncTheme([String? theme]) async {
    final result = await sync.execute(theme);
    final themeState = result.fold((l) => ThemeError(message: l.message), (r) {
      if (r == DARK_THEME) {
        return const ThemeDark();
      } else {
        return const ThemeLight();
      }
    });
    emit(themeState);
  }

  void switchTheme() {
    if (state is ThemeDark) {
      _syncTheme(LIGHT_THEME);
    } else {
      _syncTheme(DARK_THEME);
    }
  }

  bool get isDarkTheme => (state is ThemeDark) ? true : false;
}
