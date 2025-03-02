import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasaank_labzbalad/screens/components/global_snackbar.dart';
import 'package:rasaank_labzbalad/screens/favorites/provider.dart';
import 'package:rasaank_labzbalad/screens/unverified_words/word_list/provider.dart';
import 'package:rasaank_labzbalad/screens/word_details/provider.dart';
import 'package:rasaank_labzbalad/screens/word_list/view.dart';
import 'package:rasaank_labzbalad/services/database_service.dart';
import 'package:rasaank_labzbalad/themes/theme_provider.dart';
import 'screens/word_list/search_field/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final DatabaseService databaseService = DatabaseService.instance;
  await databaseService.seeder();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => WordDetailsProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => UnverifiedWordsProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: const WordList(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
