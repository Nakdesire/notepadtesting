import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteDetailScreen extends StatelessWidget {
  const NoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)?.settings.arguments as Note;
    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
      ),
    );
  }
}
