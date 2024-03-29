import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import '../utils/database_helper.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({this.note, super.key});

  final Note? note;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();
    String dateAt = DateFormat("dd/MM/yyyy").format(DateTime.now());

    if (note != null) {
      titleController.text = note!.title;
      bodyController.text = note!.body;
    }

    save() async {
      final title = titleController.value.text;
      final body = bodyController.value.text;

      if (title.isEmpty || body.isEmpty) {
        return;
      }

      final Note model =
          Note(title: title, body: body, id: note?.id, date: dateAt);
      if (note == null) {
        await DatabaseHelper.addNote(model);
      } else {
        await DatabaseHelper.updateNote(model);
      }

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Nota salva com sucesso!',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
          );
        },
      );
    }

    final PreferredSizeWidget appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 5,
      centerTitle: true,
      title: Text(note == null ? 'Nova nota' : 'Editar nota'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          save;
          Navigator.pop(context);
        },
      ),
    );
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar,
      body: noteModify(size, titleController, context, bodyController),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        tooltip: 'Salvar',
        child: const Icon(Icons.save),
      ),
    );
  }

  SafeArea noteModify(Size size, TextEditingController titleController,
      BuildContext context, TextEditingController bodyController) {
    return SafeArea(
      child: Container(
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {},
                  maxLength: 15,
                  maxLines: null,
                  autofocus: true,
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText: "Título da nota",
                    labelText: 'Título',
                  ),
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {},
                  controller: bodyController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration.collapsed(
                    hintText: "Escreva sua nota...",
                  ),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
