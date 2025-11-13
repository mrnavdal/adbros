import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/notes_provider.dart';

class NoteField extends StatefulWidget {
  final String noteId;

  const NoteField({super.key, required this.noteId});

  @override
  State<NoteField> createState() => _NoteFieldState();
}

class _NoteFieldState extends State<NoteField> {
  late TextEditingController _controller;
  String? _lastKnownValue;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveNote(NotesProvider provider) {
    provider.updateNote(widget.noteId, _controller.text);
    provider.stopEditing();
  }

  void _startEditing(NotesProvider provider) {
    provider.startEditing(widget.noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, notesProvider, child) {
        final noteValue = notesProvider.notes[widget.noteId] ?? '';
        final isEditing = notesProvider.isThisNoteEditing(widget.noteId);
        final isAnyOtherNoteEditing = notesProvider.isAnyOtherNoteEditing(
          widget.noteId,
        );

        if (!isEditing && _lastKnownValue != noteValue) {
          _lastKnownValue = noteValue;
          _controller.text = noteValue;
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: isEditing
                      ? TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Zadejte poznámku...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: null,
                        )
                      : Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          child: Text(_controller.text),
                        ),
                ),
                if (isEditing || !isAnyOtherNoteEditing) ...[
                  const SizedBox(width: 8),
                  isEditing
                      ? IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () => _saveNote(notesProvider),
                        )
                      : IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _startEditing(notesProvider),
                        ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
