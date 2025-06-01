import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/custom_icon_button.dart';
import 'package:loja_virtual_pro/models/item_size.dart';

class EditItemSize extends StatelessWidget {
  final ItemSize size;
  const EditItemSize(
      {super.key,
      required this.size,
      required this.onRemove,
      required this.onMoveUp,
      required this.onMoveDown});
  final VoidCallback onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name) {
              if (name!.isEmpty) return 'Inválido';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock) {
              if (int.tryParse(stock.toString()) == null) return 'Inválido';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock)!,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price) {
              if (num.tryParse(price.toString()) == null) {
                return 'Inválido';
              }
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price)!,
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}
