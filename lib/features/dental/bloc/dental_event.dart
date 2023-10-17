part of 'dental_bloc.dart';

@immutable
sealed class DentalEvent {}

final class LoadDataEv extends DentalEvent {}

final class Load3DModelEv extends DentalEvent {}

final class Select3DEv extends DentalEvent {}

final class XRay3DEv extends DentalEvent {}

final class DelectEv extends DentalEvent {}
