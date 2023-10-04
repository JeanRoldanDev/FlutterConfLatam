part of 'dental_bloc.dart';

@immutable
sealed class DentalState {}

final class DentalInitial extends DentalState {}

final class DentalLoading extends DentalState {}

final class DentalLoaded extends DentalState {}
