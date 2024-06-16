import 'package:digi_task/app_router.dart';
import 'package:digi_task/notifier/auth/auth_notifier.dart';
import 'package:digi_task/notifier/theme/theme_scope.dart';
import 'package:digi_task/notifier/theme/theme_scope_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.instance<AuthNotifier>(),
        ),
        
      ],
      child: const ThemeScopeWidget(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context);
    final extensions = <ThemeExtension<dynamic>>[theme.appColors, theme.appTypography];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp.router(
      locale: const Locale('az'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Digi Task',
      theme: ThemeData(
        extensions: extensions,
      ),
      routerConfig: GetIt.instance.get<AppRouter>().instance,
    );
  }
}
