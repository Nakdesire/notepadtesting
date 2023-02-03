import 'package:flutter/material.dart';

import '../models/note.dart';
import '../utils/app_routes.dart';

class NoteListWidget extends StatelessWidget {
  const NoteListWidget(
    this.note, {
    Key? key,
  }) : super(key: key);

  final Note note;

  void _selectNote(BuildContext context) {
    Navigator.of(context).pushNamed(
      AppRoutes.noteDetailScreen,
      arguments: note,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() => _selectNote(context)),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).colorScheme.primary,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: const EdgeInsets.all(5),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 220,
                      child: Text(
                        note.body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 9,
                      ),
                    ),
                  ),
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.schedule),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(note.updatedAt),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
