// ignore_for_file: cascade_invocations, unnecessary_lambdas, avoid_print

import 'package:flutter/material.dart';
import 'package:flutterconflatam/features/dental/widgets/menu_dental.dart';
import 'package:flutterconflatam/shared/shared.dart';

class DentalPage extends StatelessWidget {
  const DentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: ColoredBox(
                      color: Colors.grey,
                      child: Column(
                        children: [
                          const Text('Periodontogra'),
                          MenuDental(onTap: (value) {}),
                          Expanded(
                            child: Container(
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
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
    return Container(
      width: 470,
      color: Colors.yellow,
    );
  }
}

class ItemsTemp extends StatelessWidget {
  const ItemsTemp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.blue,
      height: double.infinity,
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
    );
  }
}
