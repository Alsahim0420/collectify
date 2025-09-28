import 'package:flutter/material.dart' hide SearchBar, Chip;
import 'package:collectify/presentation/ui/molecules/m_search_bar.dart';
import 'package:collectify/presentation/ui/atoms/a_chip.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
    this.searchQuery,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onSearchClear,
    this.recentSearches = const [],
    this.onRecentSearchTap,
  });
  final String? searchQuery;
  final void Function(String)? onSearchChanged;
  final void Function(String)? onSearchSubmitted;
  final VoidCallback? onSearchClear;
  final List<String> recentSearches;
  final void Function(String)? onRecentSearchTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(
          initialValue: searchQuery,
          onChanged: onSearchChanged,
          onSubmitted: onSearchSubmitted,
          onClear: onSearchClear,
        ),
        if (recentSearches.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text(
            'Búsquedas recientes',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: recentSearches.map((search) {
              return Chip(
                label: search,
                onTap: () => onRecentSearchTap?.call(search),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
