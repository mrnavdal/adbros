import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesProvider extends ChangeNotifier {
  late Box _notesBox;
  final Map<String, String> _notes = {};
  String? _editedNoteId;

  Map<String, String> get notes => _notes;
  String? get editedNoteId => _editedNoteId;
  bool get hasEditingNotes => _editedNoteId != null;

  void initialize() {
    _notesBox = Hive.box('notes');
    _loadExistingNotes();
  }

  void _loadExistingNotes() {
    for (final key in _notesBox.keys) {
      try {
        final value = _notesBox.get(key) as String;
        _notes[key] = value;
      } catch (e) {
        debugPrint('Failed to load note with key $key: $e');
      }
    }
    notifyListeners();
  }

  void addNewNote() {
    final newId = DateTime.now().millisecondsSinceEpoch.toString();
    _notes[newId] = '';
    _editedNoteId = newId;
    notifyListeners();
  }

  void startEditing(String noteId) {
    _editedNoteId = noteId;
    notifyListeners();
  }

  void stopEditing() {
    _editedNoteId = null;
    notifyListeners();
  }

  void updateNote(String noteId, String value) {
    if (_notes.containsKey(noteId)) {
      if (value.trim().isEmpty) {
        _notes.remove(noteId);
        _notesBox.delete(noteId);
      } else {
        _notes[noteId] = value;
        _notesBox.put(noteId, value);
      }
      notifyListeners();
    }
  }

  bool isThisNoteEditing(String noteId) {
    return _editedNoteId == noteId;
  }

  bool isAnyOtherNoteEditing(String noteId) {
    return _editedNoteId != null && _editedNoteId != noteId;
  }
}
