import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/features/dental/bloc/dental_bloc.dart';
import 'package:flutterconflatam/features/dental/widgets/widgets.dart';
import 'package:flutterconflatam/shared/shared.dart';

class DentalScreen extends StatelessWidget {
  const DentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MenuHeader(menuActive: 0),
            BlocBuilder<DentalBloc, DentalState>(
              buildWhen: (previous, current) {
                return current is DentalLoading || current is DentalLoaded;
              },
              builder: (context, state) {
                if (state is DentalLoading) {
                  return const Expanded(
                    child: Center(child: Loading()),
                  );
                }
                return Expanded(
                  child: Row(
                    children: [
                      const PanelVisor3D(),
                      ItemsTemp(state.data),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
