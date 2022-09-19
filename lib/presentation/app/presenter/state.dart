part of 'notifier.dart';

class AppState extends Equatable {
  const AppState({
    this.status = AuthStatus.unAuthenticated,
  });

  final AuthStatus status;

  @override
  List<Object> get props => [status];

  AppState copyWith({AuthStatus? status}) => AppState(status: status ?? this.status);
}
