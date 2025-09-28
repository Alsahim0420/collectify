import 'package:flutter/material.dart' hide Chip;
import 'package:collectify/presentation/ui/atoms/a_chip.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
    this.categories = const [
      'Sneakers',
      'Vinilos',
      'Cómics',
      'Figuras',
      'Ropa',
      'Libros',
      'Otros',
    ],
  });
  final String? selectedCategory;
  final void Function(String) onCategorySelected;
  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Categoría', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((category) {
            return Chip(
              label: category,
              isSelected: selectedCategory == category,
              onTap: () => onCategorySelected(category),
            );
          }).toList(),
        ),
      ],
    );
  }
}
