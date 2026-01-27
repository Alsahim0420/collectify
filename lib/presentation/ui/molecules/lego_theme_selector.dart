import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tema LEGO', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedTheme,
          decoration: InputDecoration(
            labelText: 'Selecciona un tema',
            hintText: 'Elige un tema LEGO',
            prefixIcon: const Icon(Icons.category),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: colorScheme.surface,
          ),
          items: legoThemes.map((theme) {
            return DropdownMenuItem<String>(
              value: theme,
              child: Text(theme),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onThemeSelected(value);
            }
          },
        ),
      ],
    );
  }
}
