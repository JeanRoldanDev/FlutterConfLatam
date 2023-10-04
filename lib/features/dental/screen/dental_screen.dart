import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/app/env.dart';
import 'package:flutterconflatam/app/style/ccolors.dart';
import 'package:flutterconflatam/core/human_sdk/human_ui.dart';
import 'package:flutterconflatam/features/dental/bloc/dental_bloc.dart';
import 'package:flutterconflatam/features/dental/widgets/menu_dental.dart';
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
            const MenuHeader(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const LabelTitle(
                          'Periodontograma',
                          subText: 'Ckeck Your',
                        ),
                        MenuDental(
                          onTap: (value) {},
                        ),
                        Expanded(
                          child: BlocBuilder<DentalBloc, DentalState>(
                            builder: (context, state) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  Visor3DServer(
                                    id: HumanUI.modelDentalID,
                                    apiKey: Env.instance.apiKey,
                                  ),
                                  if (state is DentalLoading)
                                    ColoredBox(
                                      color: CColors.background,
                                      child: const Loading(),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const ItemsTemp(),
                  const Details(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 470,
      child: Column(
        children: [
          LabelTitle(
            subText: 'Details',
            '',
          ),
        ],
      ),
    );
  }
}

class ItemsTemp extends StatelessWidget {
  const ItemsTemp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Column(
        children: [
          const LabelTitle(
            subText: 'Items',
            'Registros',
          ),
          Container(
            height: 50,
            color: Colors.green,
          ),
          Expanded(
            child: ListViewRadius(
              itemCount: 20,
              colorItem: Colors.grey,
              itemBuilder: (context, index) {
                return Item(
                  child: Center(
                    child: Text(index.toString()),
                  ),
                  childPallette:
                      (index == 0 || index == 3 || index == 2 || index == 10)
                          ? const Center(child: Icon(Icons.add))
                          : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
