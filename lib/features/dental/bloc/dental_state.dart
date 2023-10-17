part of 'dental_bloc.dart';

@immutable
sealed class DentalState {
  const DentalState(this.data);

  final List<ItemDental> data;
}

final class DentalInitial extends DentalState {
  const DentalInitial(super.data);
}

final class DentalLoading extends DentalState {
  const DentalLoading(super.data);
}

final class DentalLoaded extends DentalState {
  const DentalLoaded(super.data);
}

final class Model3DLoading extends DentalState {
  const Model3DLoading(super.data);
}

final class Model3DLoaded extends DentalState {
  const Model3DLoaded(super.data);
}

final class Error extends DentalState {
  const Error(this.msg, super.data);

  final String msg;
}
