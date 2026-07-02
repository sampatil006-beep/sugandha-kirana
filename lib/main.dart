import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/home/presentation/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://hsjylmgkczrzwlmxuygj.supabase.co',
    anonKey: 'sb_publishable_GXgr2BeGCZENZycywRVyUA_3A8J7cGo',
  );

  runApp(
    const ProviderScope(
      child: SugandhaKiranaApp(),
    ),
  );
}

class SugandhaKiranaApp extends StatelessWidget {
  const SugandhaKiranaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sugandha Kirana',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        cardTheme: const CardThemeData(
          margin: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}