import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/section.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.section, {super.key});

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section.name,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}
