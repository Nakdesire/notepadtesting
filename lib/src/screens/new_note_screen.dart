import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen(this.onSubmit, {super.key});

  final void Function(String, String, String)? onSubmit;

  @override
  State<NewNoteScreen> createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  String updatedAt = DateFormat("dd/MM/yyyy").format(DateTime.now());

  _submitNote() {
    final title = _titleController.text;
    final body = _bodyController.text;

    if (title.isEmpty || body.isEmpty) {
      return;
    }
    widget.onSubmit!(title, body, updatedAt);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Note"),
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          padding: const EdgeInsets.all(16),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    onFieldSubmitted: ((_) => _submitNote()),
                    maxLines: null,
                    autofocus: true,
                    controller: _titleController,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Titulo da nota",
                    ),
                    style: const TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onFieldSubmitted: ((_) => _submitNote()),
                    controller: _bodyController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration.collapsed(
                      hintText: "Escreva sua nota...",
                    ),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_titleController.text.isEmpty && _bodyController.text.isEmpty) {
            return;
          } else {
            _submitNote;
          }
        },
        label: const Text("Save"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
