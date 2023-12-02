part of 'cardiologist_bloc.dart';

@immutable
sealed class CardiologistState {
  const CardiologistState({required this.cardioData});

  final CardioData cardioData;
}

final class Initial extends CardiologistState {
  const Initial() : super(cardioData: CardioData.zero);
}

final class Loading extends CardiologistState {
  const Loading() : super(cardioData: CardioData.zero);
}

final class Loaded extends CardiologistState {
  const Loaded() : super(cardioData: CardioData.zero);
}

final class Success extends CardiologistState {
  const Success() : super(cardioData: CardioData.zero);
}

final class HasResult extends CardiologistState {
  const HasResult({required super.cardioData});
}

final class Error extends CardiologistState {
  const Error(this.msg) : super(cardioData: CardioData.zero);

  final String msg;
}
