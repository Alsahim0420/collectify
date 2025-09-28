import 'package:flutter/material.dart' hide Chip;
import 'package:collectify/presentation/ui/atoms/a_chip.dart';

class LegoThemeSelector extends StatelessWidget {
  const LegoThemeSelector({
    super.key,
    this.selectedTheme,
    required this.onThemeSelected,
  });
  final String? selectedTheme;
  final void Function(String) onThemeSelected;

  static const List<String> legoThemes = [
    'Star Wars',
    'Technic',
    'City',
    'Creator',
    'Friends',
    'Ninjago',
    'Marvel',
    'DC Comics',
    'Disney',
    'Architecture',
    'Ideas',
    'Speed Champions',
    'Classic',
    'Duplo',
    'Minecraft',
    'Harry Potter',
    'Jurassic World',
    'Monkie Kid',
    'Hidden Side',
    'Vidiyo',
    'Art',
    'Botanical',
    'Icons',
    'Dots',
    'Super Mario',
    'Sonic',
    'Overwatch',
    'Stranger Things',
    'Adults Welcome',
    'Otros',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tema LEGO', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: legoThemes.map((theme) {
            return Chip(
              label: theme,
              isSelected: selectedTheme == theme,
              onTap: () => onThemeSelected(theme),
            );
          }).toList(),
        ),
      ],
    );
  }
}
