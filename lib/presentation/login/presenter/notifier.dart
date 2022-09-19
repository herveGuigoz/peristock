part of 'presenter.dart';

class _LoginFormNotifier extends StateNotifier<LoginState> {
  _LoginFormNotifier({required this.sessionRepository}) : super(const LoginState());

  @protected
  final SessionRepositoryInterface sessionRepository;

  void setEmail(String value) {
    state = state.copyWith(email: Email(value));
  }

  Future<void> submit() async {
    state = state.copyWith(status: const FormStatus.submissionInProgress());
    try {
      await sessionRepository.signIn(email: state.email.value, isWeb: false);
      state = state.copyWith(status: const FormStatus.submissionSucceed());
    } catch (error) {
      state = state.copyWith(status: FormStatus.submissionFailled(error));
    }
  }
}
