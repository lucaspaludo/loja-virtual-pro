import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/section.dart';
import 'package:loja_virtual_pro/screens/home/components/item_tile.dart';
import 'package:loja_virtual_pro/screens/home/components/section_header.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section, {super.key});

  final Section section;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ItemTile(section.items[index]);
              },
              separatorBuilder: (_, __) => const SizedBox(width: 4),
              itemCount: section.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
