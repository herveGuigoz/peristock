part of 'presenter.dart';

class _LoginFormNotifier extends StateNotifier<LoginState> {
  _LoginFormNotifier({required this.sessionRepository}) : super(const LoginState());

  @protected
  final SessionRepositoryInterface sessionRepository;

  void setEmail(String value) {
    final email = state.email.copyWith(value: value);
    state = state.copyWith(email: email);
  }

  Future<void> submit() async {
    state = state.copyWith(status: const FormStatus.submissionInProgress());
    try {
      await sessionRepository.signInWithOtp(email: state.email.value, isWeb: false);
      state = state.copyWith(status: const FormStatus.submissionSucceed());
    } catch (error) {
      state = state.copyWith(status: FormStatus.submissionFailled(error));
    }
  }
}
