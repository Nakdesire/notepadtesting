import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import '../utils/database_helper.dart';
import 'note_detail_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> notes = [];
  int notesLength = 0;
  @override
  Widget build(BuildContext context) {
    updateListView();
    final mediaQuery = MediaQuery.of(context);
    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text("Anotações"),
      elevation: 5,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => navigateToDetail(
            Note(
              0,
              " ",
              " ",
              " ",
            ),
            'Nova nota',
          ),
          tooltip: 'Add Note',
        ),
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final availableWidth = mediaQuery.size.width -
        mediaQuery.padding.right -
        mediaQuery.padding.top;

    final cardHeight = availableHeight * 0.35;

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: GridView.builder(
            itemCount: notes.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: availableWidth * 0.48,
              mainAxisExtent: availableHeight * 0.35,
              crossAxisSpacing: availableWidth * 0.05,
              mainAxisSpacing: availableHeight * 0.005,
            ),
            itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    navigateToDetail(this.notes[index], 'Edit Note');
                  },
                  onLongPress: () {},
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: cardHeight * 0.65,
                            child: Text(
                              notes[index].body,
                              overflow: TextOverflow.fade,
                              maxLines: 9,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: cardHeight * 0.1,
                            child: Text(
                              notes[index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: cardHeight * 0.1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.schedule),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  notes[index].date,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToDetail(
          Note(
            0,
            " ",
            " ",
            " ",
          ),
          'Nova nota',
        ),
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _delete(context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Nota deletada com sucesso!');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetailScreen(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.notes = noteList;
          this.notesLength = noteList.length;
        });
      });
    });
  }
}
