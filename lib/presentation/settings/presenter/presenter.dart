import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/domain/shared/result.dart';
import 'package:peristock/presentation/app/presenter/presenter.dart';

abstract class SettingsPresenter {
  // static StateProvider<AppTheme> get theme => themeProvider;

  // static void switchTheme(WidgetRef ref) {
  //   final theme = ref.read(themeProvider);
  //   ref.read(themeProvider.notifier).state = theme == AppTheme.dark ? AppTheme.light : AppTheme.dark;
  // }

  static Future<Result<void>> logOut(WidgetRef ref) async {
    return Result.guard(() => ref.read(AppPresenter.state.notifier).signOut());
  }
}
