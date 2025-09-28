import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collectify/app/di/injector.dart';
import 'package:collectify/app/routing/app_router.dart';
import 'package:collectify/app/theme/app_theme.dart';
import 'package:collectify/app/utils/logger.dart';
import 'package:collectify/presentation/state/collection/collection_bloc.dart';
import 'package:collectify/presentation/state/collection_selection/collection_selection_bloc.dart';
import 'package:collectify/domain/usecases/get_lego_sets.dart';
import 'package:collectify/domain/usecases/add_lego_set.dart';
import 'package:collectify/domain/usecases/update_lego_set.dart';
import 'package:collectify/domain/usecases/delete_lego_set.dart';
import 'package:collectify/domain/usecases/get_collections.dart';
import 'package:collectify/domain/usecases/add_collection.dart';
import 'package:collectify/domain/usecases/delete_collection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //? Inicializar inyección de dependencias
  await initInjector();

  //? Configurar logger
  Logger.info('App iniciada');

  runApp(const CollectifyApp());
}

class CollectifyApp extends StatelessWidget {
  const CollectifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CollectionBloc>(
          create: (context) => CollectionBloc(
            sl<GetLegoSets>(),
            sl<AddLegoSet>(),
            sl<UpdateLegoSet>(),
            sl<DeleteLegoSet>(),
          ),
        ),
        BlocProvider<CollectionSelectionBloc>(
          create: (context) => CollectionSelectionBloc(
            sl<GetCollections>(),
            sl<AddCollection>(),
            sl<DeleteCollection>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Collectify',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
