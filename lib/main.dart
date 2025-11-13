import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'state/notes_provider.dart';
import 'ui/notes_page.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('notes');
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = NotesProvider();
        provider.initialize();
        return provider;
      },
      child: MaterialApp(
        title: 'Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NotesPage(),
      ),
    );
  }
}
