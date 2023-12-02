import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/widgets.dart';
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
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Cardiogram(),
                BlocBuilder<CardiologistBloc, CardiologistState>(
                  buildWhen: (previous, current) {
                    return current is Initial ||
                        current is Loading ||
                        current is Loaded ||
                        current is Success;
                  },
                  builder: (context, state) {
                    if (state is Loading) {
                      return Container(
                        color: CColors.background,
                        alignment: Alignment.center,
                        child: const Column(
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Loading...!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is Loaded) {
                      return Container(
                        color: CColors.background,
                        alignment: Alignment.center,
                        child: const Column(
                          children: [
                            Icon(
                              Symbols.fingerprint_rounded,
                              size: 80,
                              color: Colors.red,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Place your finger',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            StartCount(),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
