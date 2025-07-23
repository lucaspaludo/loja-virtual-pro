import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/models/home_maneger.dart';
import 'package:provider/provider.dart';

import '../../../models/section.dart';

class AddSectionWidget extends StatelessWidget {
  final HomeManager homeManager;

  const AddSectionWidget(this.homeManager, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            child: const Text('Adicionar Lista'),
            onPressed: () {
              homeManager.addSection(Section(type: 'List'));
            },
          ),
        ),
        Expanded(
          child: ElevatedButton(
            child: const Text('Adicionar Grade'),
            onPressed: () {
              homeManager.addSection(Section(type: 'Staggered'));
            },
          ),
        ),
      ],
    );
  }
}
