import 'package:go_router/go_router.dart';
import 'package:collectify/presentation/ui/pages/p_home_page.dart';
import 'package:collectify/presentation/ui/pages/p_form_page.dart';
import 'package:collectify/presentation/ui/pages/p_details_page.dart';
import 'package:collectify/presentation/ui/pages/p_collections_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'collections',
      builder: (context, state) => const CollectionsPage(),
    ),
    GoRoute(
      path: '/home/:collectionId',
      name: 'home',
      builder: (context, state) {
        final collectionId = state.pathParameters['collectionId']!;
        return HomePage(selectedCollectionId: collectionId);
      },
    ),
    GoRoute(
      path: '/add',
      name: 'add',
      builder: (context, state) => const FormPage(),
    ),
    GoRoute(
      path: '/edit/:id',
      name: 'edit',
      builder: (context, state) {
        // En una implementación real, aquí buscarías el set por ID
        // Por simplicidad, pasamos null y el FormPage manejará la carga
        return const FormPage(existingSet: null);
      },
    ),
    GoRoute(
      path: '/details/:id',
      name: 'details',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsPage(itemId: id);
      },
    ),
  ],
);
