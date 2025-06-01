import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/customDrawer/custom_icon_button.dart';
import 'package:loja_virtual_pro/models/item_size.dart';
import 'package:loja_virtual_pro/models/product.dart';
import 'package:loja_virtual_pro/screens/edit_product/components/edit_item_size.dart';

class SizesForm extends StatelessWidget {
  final Product product;

  const SizesForm(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
      initialValue: List.from(product.sizes),
      validator: (sizes) {
        if (sizes!.isEmpty) return 'Insira um tamanho';
        return null;
      },
      builder: (state) {
        return Column(
          children: [
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomIconButton(
                  iconData: Icons.add,
                  color: Colors.black,
                  onTap: () {
                    state.value?.add(ItemSize());
                    state.didChange(state.value);
                  },
                )
              ],
            ),
            Column(
              children: state.value!.map((size) {
                return EditItemSize(
                  key: ObjectKey(size),
                  size: size,
                  onRemove: () {
                    state.value!.remove(size);
                    state.didChange(state.value);
                  },
                  onMoveUp: size != state.value!.first
                      ? () {
                          final index = state.value!.indexOf(size);
                          state.value!.remove(size);
                          state.value!.insert(index - 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                  onMoveDown: size != state.value!.last
                      ? () {
                          final index = state.value!.indexOf(size);
                          state.value!.remove(size);
                          state.value!.insert(index + 1, size);
                          state.didChange(state.value);
                        }
                      : null,
                );
              }).toList(),
            ),
            if(state.hasError) 
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16,)
          ],
        );
      },
    );
  }
}
