part of 'cardiologist_bloc.dart';

@immutable
sealed class CardiologistState {}

final class Initial extends CardiologistState {}

final class Loading extends CardiologistState {}

final class Loaded extends CardiologistState {}

final class Success extends CardiologistState {}

final class HasResult extends CardiologistState {
  HasResult(this.data);

  final CardioData data;
}

final class Error extends CardiologistState {
  Error(this.msg);

  final String msg;
}
