import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loja_virtual_pro/models/section.dart';
import 'package:loja_virtual_pro/screens/home/components/item_tile.dart';
import 'package:loja_virtual_pro/screens/home/components/section_header.dart';

class SectionStaggered extends StatelessWidget {
  const SectionStaggered(this.section, {super.key});

  final Section section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          MasonryGridView.count(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: section.items.length,
            itemBuilder: (_, index) {
              return ItemTile(section.items[index]);
            },
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
        ],
      ),
    );
  }
}
