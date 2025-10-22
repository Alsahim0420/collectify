import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:collectify/presentation/state/collection/collection_bloc.dart';
import 'package:collectify/presentation/state/collection/collection_event.dart';
import 'package:collectify/presentation/state/collection/collection_state.dart';
import 'package:collectify/presentation/ui/pages/p_form_page.dart';
import 'package:collectify/presentation/ui/pages/p_details_page.dart';
import 'package:collectify/presentation/ui/molecules/m_set_card.dart';
import 'package:collectify/presentation/ui/atoms/a_text.dart';
import 'package:collectify/presentation/ui/atoms/a_primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.selectedCollectionId});

  final String? selectedCollectionId;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<CollectionBloc>().add(LoadItems());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Mi Colección LEGO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: widget.selectedCollectionId != null
            ? IconButton(
                onPressed: () => context.go('/'),
                icon: const Icon(Icons.arrow_back),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              _showSearchDialog(context);
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.collections),
          ),
        ],
      ),
      body: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return switch (state) {
            CollectionInitial() => _buildEmptyState(context),
            CollectionLoading() => _buildLoadingState(context),
            CollectionLoaded(items: final items) => _buildLoadedState(
              context,
              items,
            ),
            CollectionError(message: final m) => _buildErrorState(context, m),
          };
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const FormPage()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar Set'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ilustración animada
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Círculo de fondo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Icono principal
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.extension,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  // Elementos decorativos
                  Positioned(
                    top: 20,
                    right: 30,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 20,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Título principal
            Title(
              '¡Construye tu colección!',
              color: Colors.grey[800],
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Subtítulo
            Subtitle(
              'Comienza agregando tu primer set y construye la colección de tus sueños',
              color: Colors.grey[600],
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Botón principal
            PrimaryButton(
              label: 'Agregar mi primer set',
              icon: Icons.add_circle_outline,
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FormPage()),
                );
              },
            ),
            const SizedBox(height: 24),
            // Tips adicionales
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[200]!, width: 1),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Colors.blue[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Title('Consejos para organizar', color: Colors.blue[800]),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Body(
                    '• Agrega el nombre completo del set\n• Incluye el número de serie LEGO\n• Organiza por temas (Star Wars, Technic, etc.)\n• Añade notas personales sobre tu experiencia',
                    color: Colors.blue[700],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Cargando tu colección...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, List<dynamic> items) {
    if (items.isEmpty) {
      return _buildEmptyState(context);
    }

    // Filtrar items por colección y búsqueda
    var filteredItems = items;

    // Filtrar por colección seleccionada
    if (widget.selectedCollectionId != null) {
      filteredItems = filteredItems
          .where((set) => set.collectionId == widget.selectedCollectionId)
          .toList();
    }

    // Filtrar por búsqueda
    if (_searchQuery.isNotEmpty) {
      filteredItems = filteredItems.where((set) {
        final query = _searchQuery.toLowerCase();
        return set.name.toLowerCase().contains(query) ||
            set.theme.toLowerCase().contains(query) ||
            set.setNumber.toString().contains(query);
      }).toList();
    }

    return Column(
      children: [
        // Barra de búsqueda
        if (_searchQuery.isNotEmpty) _buildSearchBar(context),
        // Lista de items
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<CollectionBloc>().add(LoadItems());
            },
            child: filteredItems.isEmpty
                ? _buildNoResultsState(context)
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final set = filteredItems[index];
                      return SetCard(
                        set: set,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsPage(itemId: set.id),
                          ),
                        ),
                        onEdit: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FormPage(existingSet: set),
                          ),
                        ),
                        onDelete: () {
                          context.read<CollectionBloc>().add(
                            DeleteItemEvent(set.id),
                          );
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            const Title('Error al cargar la colección'),
            const SizedBox(height: 8),
            Subtitle(
              message,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Reintentar',
              icon: Icons.refresh,
              onPressed: () {
                context.read<CollectionBloc>().add(LoadItems());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, tema o número...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.clear),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            const Title('No se encontraron resultados'),
            const SizedBox(height: 8),
            Subtitle(
              'Intenta con otros términos de búsqueda',
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Limpiar búsqueda',
              icon: Icons.clear,
              onPressed: _clearSearch,
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buscar en tu colección'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar por nombre, tema o número...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _clearSearch();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }

  void _clearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }
}
