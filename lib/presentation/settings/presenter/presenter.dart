import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peristock/application/shared/result.dart';
import 'package:peristock/presentation/app/presenter/presenter.dart';

abstract class SettingsPresenter {
  static Future<Result<void>> logOut(WidgetRef ref) {
    return Result.guard(() => ref.read(AppPresenter.state.notifier).signOut());
  }
}
