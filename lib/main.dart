import 'package:bancadigital_bm_red_designsystem/bancadigital_bm_red_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'generated/l10n.dart';
import 'router/go_router_config.dart';

void main() async {
  GoRouter routerConfig = GoRouterConfig.getRouterConfig();

  runApp(ProviderScope(child: MyApp(routerConfig: routerConfig)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routerConfig});

  final GoRouter routerConfig;

  @override
  Widget build(BuildContext context) {
    BacSnackbarUtils.initialize(scaffoldMessengerKey);

    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Comprobac',
      darkTheme: BacThemeManager.buildDarkTheme(),
      theme: BacThemeManager.buildLightTheme(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      routerConfig: routerConfig,
    );
  }
}
