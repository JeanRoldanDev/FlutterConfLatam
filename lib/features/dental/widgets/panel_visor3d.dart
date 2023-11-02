import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/config/env.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/core/core.dart';
import 'package:flutterconflatam/features/dental/bloc/dental_bloc.dart';
import 'package:flutterconflatam/features/dental/widgets/menu_dental.dart';
import 'package:flutterconflatam/shared/shared.dart';

class PanelVisor3D extends StatelessWidget {
  const PanelVisor3D({
    super.key,
  });

  void onTapMenu(BuildContext context, int value) {
    if (value == 0) {
      context.read<DentalBloc>().add(Select3DEv());
    }
    if (value == 1) {
      context.read<DentalBloc>().add(XRay3DEv());
    }
    if (value == 2) {
      context.read<DentalBloc>().add(DelectEv());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const LabelTitle(
            'Periodontograma',
            subText: 'Ckeck Your',
          ),
          MenuDental(
            onTap: (value) => onTapMenu(context, value),
          ),
          Expanded(
            child: Stack(
              children: [
                Visor3DServer(
                  id: HumanUI.modelDentalID,
                  apiKey: Env.instance.apiKey,
                ),
                BlocBuilder<DentalBloc, DentalState>(
                  buildWhen: (previous, current) {
                    return current is Model3DLoading ||
                        current is Model3DLoaded;
                  },
                  builder: (context, state) {
                    if (state is Model3DLoading) {
                      return ColoredBox(
                        color: CColors.background,
                        child: const Loading(),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
