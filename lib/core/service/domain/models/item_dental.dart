import 'package:equatable/equatable.dart';
import 'package:flutterconflatam/core/service/domain/models/models.dart';

class ItemDental extends Equatable {
  const ItemDental({required this.piece, this.perio});

  final PieceDental piece;
  final PerioDental? perio;

  static const all = <ItemDental>[
    ItemDental(
      piece: Piceses.p18,
    ),
    ItemDental(
      piece: Piceses.p17,
      perio: Perios.p1,
    ),
    ItemDental(
      piece: Piceses.p16,
    ),
    ItemDental(
      piece: Piceses.p15,
    ),
    ItemDental(
      piece: Piceses.p14,
      perio: Perios.p1,
    ),
    ItemDental(
      piece: Piceses.p13,
      perio: Perios.p1,
    ),
    ItemDental(
      piece: Piceses.p12,
    ),
    ItemDental(
      piece: Piceses.p11,
    ),
  ];

  @override
  List<Object?> get props => [piece, perio];
}
