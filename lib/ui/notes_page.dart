import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/notes_provider.dart';
import 'note_field.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poznámky'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final noteEntries = notesProvider.notes.entries.toList();

          return ListView.builder(
            itemCount: noteEntries.length + 1,
            itemBuilder: (context, index) {
              if (index < noteEntries.length) {
                final noteId = noteEntries[index].key;
                return NoteField(key: ValueKey(noteId), noteId: noteId);
              }

              if (!notesProvider.hasEditingNotes) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.add_circle_outline, size: 32),
                      onPressed: () => notesProvider.addNewNote(),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
