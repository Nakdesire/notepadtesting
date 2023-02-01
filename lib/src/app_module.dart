import 'package:flutter/material.dart';
import 'package:notepad/src/screens/note_detail.dart';
import 'package:notepad/src/utils/app_routes.dart';
import 'screens/note_list.dart';
import 'utils/color_schemes.dart';

class NotepadApp extends StatelessWidget {
  NotepadApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      routes: {
        AppRoutes.noteListScreen: (context) => const NoteList(),
        AppRoutes.noteDetailScreen: (context) => const NoteDetailScreen(),
      },
    );
  }
}
