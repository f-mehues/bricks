import 'package:apapa/app_config/app_config.dart';
import 'package:app_config_repository/app_config_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({required this.appConfigRepository, super.key});

  final AppConfigRepository appConfigRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: appConfigRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppBloc(
              appConfigRepository: appConfigRepository,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('App config Example'),
      ),
      body: Center(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            if (state.status == AppStatus.downForMaintenance) {
              return const Text(
                'The app is down for maintenance, we apologize for the inconvenience',
              );
            } else if (state.status == AppStatus.forceUpgradeRequired) {
              return const Text(
                'A new version of the app is ready for upgrade',
              );
            } else {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'This is the Home View of the App Config Example',
                  ),
                ],
              );
            }
          },
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
