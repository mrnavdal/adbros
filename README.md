# Notes App

A simple Flutter notes application with local persistence.

## Features

- Create, edit, and delete notes
- Local storage using Hive database
- State management with Provider
- Single note editing mode (only one note can be edited at a time)
- Clean architecture with separated concerns

## Project Structure

```
lib/
├── main.dart              # App initialization and setup
├── state/
│   └── notes_provider.dart # State management with Provider
└── ui/
    ├── notes_page.dart     # Main notes list page
    └── note_field.dart     # Individual note widget
```

## Tech Stack

- **Flutter** - UI framework
- **Hive** - Local NoSQL database
- **Provider** - State management

## Getting Started

1. Install dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run
```

## How It Works

Notes are stored as key-value pairs in Hive:
- Key: Unique timestamp ID
- Value: Note text content

The app uses a single `Map<String, String>` in the provider to manage notes in memory, synced with the Hive database.
