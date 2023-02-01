import 'package:flutter/material.dart';
import 'package:notepad/src/data/dummy_data.dart';
import '../widgets/note_list_widget.dart';

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 5,
      scrolledUnderElevation: 5,
      title: const Text('Anotações'),
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 300,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: dummyNotes.map((note) {
                  return NoteListWidget(note);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}),
    );
  }
}
