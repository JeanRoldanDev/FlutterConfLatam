part of 'cardiologist_bloc.dart';

@immutable
sealed class CardiologistEvent {}

final class ReadPulserEv extends CardiologistEvent {}

final class UpdateResultEv extends CardiologistEvent {
  UpdateResultEv(this.data);

  final CardioData data;
}

final class ViewChartEv extends CardiologistEvent {}

final class ResetPulserEv extends CardiologistEvent {}
