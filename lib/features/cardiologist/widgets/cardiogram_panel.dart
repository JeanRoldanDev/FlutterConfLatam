import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/cardiogram.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardiogramPanel extends StatelessWidget {
  const CardiogramPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LayoutBuilder(
        builder: (context, box) {
          return SizedBox(
            width: box.maxWidth,
            height: box.maxHeight,
            child: BlocBuilder<CardiologistBloc, CardiologistState>(
              buildWhen: (previous, current) {
                return current is Initial ||
                    current is Loading ||
                    current is Loaded ||
                    current is Success;
              },
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is Loaded) {
                  return const Center(
                    child: Icon(
                      Symbols.fingerprint_rounded,
                      size: 80,
                      color: Colors.red,
                    ),
                  );
                }

                if (state is Success) {
                  return Cardiogram(
                    dataStream: context.read<CardiologistBloc>().streamPulser,
                    size: Size(box.maxWidth, box.maxHeight),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
