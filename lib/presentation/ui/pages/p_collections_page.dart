import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/presentation/state/collection/collection_bloc.dart';
import 'package:collectify/presentation/state/collection/collection_event.dart';
import 'package:collectify/presentation/state/collection/collection_state.dart';
import 'package:collectify/presentation/ui/atoms/a_text.dart';
import 'package:collectify/presentation/ui/atoms/a_primary_button.dart';
import 'package:collectify/presentation/ui/pages/p_form_page.dart';
import 'package:collectify/presentation/ui/pages/p_details_page.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  @override
  void initState() {
    super.initState();
    context.read<CollectionBloc>().add(LoadItems());
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
      ),
      body: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return switch (state) {
            CollectionLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CollectionError(message: final message) => Center(
              child: Text('Error: $message'),
            ),
            CollectionLoaded(items: final items) => _buildLoadedState(
              context,
              items,
            ),
            _ => _buildEmptyState(context),
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

  Widget _buildLoadedState(BuildContext context, List<LegoSet> sets) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsHeader(context, sets.length),
          const SizedBox(height: 24),
          if (sets.isEmpty)
            _buildEmptyState(context)
          else
            _buildSetsList(context, sets),
        ],
      ),
    );
  }

  Widget _buildStatsHeader(BuildContext context, int totalSets) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                context,
                'Sets Totales',
                totalSets.toString(),
                Icons.extension,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '¡Bienvenido a tu colección LEGO!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildSetsList(BuildContext context, List<LegoSet> sets) {
    return Column(
      children: sets.map((set) => _buildSetCard(context, set)).toList(),
    );
  }

  Widget _buildSetCard(BuildContext context, LegoSet set) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailsPage(itemId: set.id)),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.extension,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Title(set.name, color: Colors.black87),
                    const SizedBox(height: 4),
                    Subtitle(
                      'Set #${set.setNumber} • ${set.pieces} piezas',
                      color: Colors.grey[600],
                    ),
                    if (set.theme.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Subtitle('Tema: ${set.theme}', color: Colors.grey[500]),
                    ],
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
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
            Icon(Icons.extension_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Title(
              '¡Comienza tu colección LEGO!',
              color: Colors.grey[800],
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Subtitle(
              'Agrega tu primer set LEGO y construye la colección de tus sueños',
              color: Colors.grey[600],
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
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
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.blue[800]),
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
}
