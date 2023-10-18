import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cardiologist_event.dart';
part 'cardiologist_state.dart';

class CardiologistBloc extends Bloc<CardiologistEvent, CardiologistState> {
  CardiologistBloc() : super(CardiologistInitial()) {
    on<CardiologistEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
