import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterconflatam/features/cardiologist/bloc/cardiologist_bloc.dart';
import 'package:flutterconflatam/shared/shared.dart';
import 'package:material_symbols_icons/symbols.dart';

class ItemsDataValue extends StatelessWidget {
  const ItemsDataValue({super.key});

  static const list = <Item>[
    Item(
      child: ItemBPM(),
    ),
    Item(
      child: ItemSPO(),
      childPallette: Center(
        child: Icon(Symbols.home_storage),
      ),
    ),
    Item(
      child: ItemFrequency(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Column(
        children: [
          const LabelTitle(
            subText: 'Items',
            'Registers',
          ),
          const SizedBox(height: 50),
          Expanded(
            child: ListViewRadius(
              itemCount: list.length,
              colorItem: Colors.grey,
              itemBuilder: (context, index) {
                return list[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemBPM extends StatelessWidget {
  const ItemBPM({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BMP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                BlocBuilder<CardiologistBloc, CardiologistState>(
                  buildWhen: (previous, current) {
                    return current is HasResult;
                  },
                  builder: (context, state) {
                    return Text(
                      (state is HasResult)
                          ? state.data.bpm.toInt().toString()
                          : '0',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Icon(
                Symbols.ecg_heart_rounded,
                size: 70,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemSPO extends StatelessWidget {
  const ItemSPO({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SPO2',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                BlocBuilder<CardiologistBloc, CardiologistState>(
                  buildWhen: (previous, current) {
                    return current is HasResult;
                  },
                  builder: (context, state) {
                    return Text(
                      (state is HasResult) ? '${state.data.spo2}%' : '0.00%',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Icon(
                Symbols.spo2_rounded,
                size: 75,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ItemFrequency extends StatelessWidget {
  const ItemFrequency({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ECH',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
                BlocBuilder<CardiologistBloc, CardiologistState>(
                  buildWhen: (previous, current) {
                    return current is HasResult;
                  },
                  builder: (context, state) {
                    return Text(
                      (state is HasResult) ? '${state.data.ech}%' : '0.00%',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Icon(
                Symbols.cardiology,
                size: 75,
              ),
            ),
          )
        ],
      ),
    );
  }
}
