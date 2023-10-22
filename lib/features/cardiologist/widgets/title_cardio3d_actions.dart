import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/widgets/widgets.dart';
import 'package:flutterconflatam/shared/shared.dart';
import 'package:material_symbols_icons/symbols.dart';

class TitleCardio3DActions extends StatelessWidget {
  const TitleCardio3DActions({super.key});

  void load(BuildContext context) {
    context.read<CardiologistBloc>().add(ReadPulserEv());
  }

  void reset(BuildContext context) {
    context.read<CardiologistBloc>().add(ResetPulserEv());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: LabelTitle(
                  'Cardiologist',
                  subText: 'Ckeck Your',
                ),
              ),
              CircularIcon(
                icon: Symbols.pacemaker_rounded,
                onTap: () => load(context),
                size: 35,
              ),
              const SizedBox(width: 10),
              CircularIcon(
                icon: Symbols.relax_rounded,
                onTap: () => reset(context),
                size: 35,
              ),
              const SizedBox(width: 30),
              CircularIcon(
                icon: Symbols.abc,
                onTap: () =>
                    {context.read<CardiologistBloc>().add(ResetPulserEv())},
                size: 35,
              ),
            ],
          ),
          const PanelVisorHeart3D(),
        ],
      ),
    );
  }
}
