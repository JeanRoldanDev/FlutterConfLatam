import 'package:flutter/material.dart';
import 'package:flutterconflatam/core/human_sdk/data/item_dental.dart';
import 'package:flutterconflatam/features/dental/widgets/widgets.dart';
import 'package:flutterconflatam/shared/shared.dart';
import 'package:material_symbols_icons/symbols.dart';

class ItemsTemp extends StatelessWidget {
  const ItemsTemp(
    this.itemsDental, {
    super.key,
  });

  final List<ItemDental> itemsDental;

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
          Expanded(
            child: ListViewRadius(
              itemCount: itemsDental.length,
              colorItem: Colors.grey,
              itemBuilder: (context, index) {
                final tooth = itemsDental[index];
                return Item(
                  child: Row(
                    children: [
                      ToohImg(
                        tooth: tooth,
                        onTap: () {
                          print(tooth.piece.id);
                        },
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Diente #${tooth.piece.cod}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blueGrey.shade800,
                                ),
                              ),
                              Text(
                                '${tooth.piece.name}\n'
                                '${tooth.piece.position}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tooth.perio != null
                                        ? 'Contiene Registro\nPeriodental'
                                        : 'Sin Registro',
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  childPallette: tooth.perio != null
                      ? Center(
                          child: InkWell(
                            onTap: () {},
                            child: const Icon(Symbols.home_storage),
                          ),
                        )
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
