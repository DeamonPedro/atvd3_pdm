import 'package:atvd3_pdm/models/Note.dart';
import 'package:atvd3_pdm/provider/note_provider.dart';
import 'package:feather_icons_svg/feather_icons_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePage();
}

class _NotePage extends State<NotePage> {
  bool _isSaving = false;
  NoteProvider noteProvider = NoteProvider.instance;
  @override
  Widget build(BuildContext context) {
    final note = ModalRoute.of(context)!.settings.arguments as Note;
    final noteExists = noteProvider.noteList.contains(note);

    print(noteProvider.noteList.contains(note));

    onSaveNote() async {
      setState(() {
        _isSaving = true;
      });
      note.lastUpdate = DateTime.now().millisecondsSinceEpoch;
      await noteProvider.saveNote(note);
      setState(() {
        _isSaving = false;
      });
    }

    onDeleteNote() async {
      await noteProvider.deleteNote(note.id);
      Navigator.pop(context);
    }

    toggleFavorited() async {
      note.favorited = !note.favorited;
      noteProvider.saveNote(note);
      setState(() {});
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff161616), Color(0xff383838)],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      iconSize: 40,
                      onPressed: () => Navigator.pop(context),
                      icon: const FeatherIcon(
                        FeatherIcons.chevronLeft,
                        color: Color(0xff745F5F),
                      ),
                    ),
                    Text(
                      noteExists ? 'Edit Note' : 'New note',
                      style: const TextStyle(
                        color: Color(0xff745F5F),
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(width: 40)
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                            ),
                            color: Color(0xff616161),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: FeatherIcon(
                              FeatherIcons.edit3,
                              color: Color(0xffebebeb),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                              ),
                              color: Color(0xff616161),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TextFormField(
                                initialValue: note.title,
                                onChanged: (value) {
                                  note.title = value;
                                },
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Color(0xffebebeb),
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          color: Color(0xffb5b5b5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          initialValue: note.text,
                          onChanged: (value) {
                            note.text = value;
                          },
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xff262626),
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          deleteButton(
                            key: UniqueKey(),
                            onPressed: onDeleteNote,
                            enable: noteExists,
                          ),
                          const SizedBox(width: 10),
                          favoriteButton(
                              favorited: note.favorited,
                              onPressed: toggleFavorited),
                          const SizedBox(width: 10),
                          saveButton(onPressed: onSaveNote),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget deleteButton({
    Key? key,
    bool enable = true,
    required void Function()? onPressed,
  }) {
    return Flexible(
      key: key,
      fit: FlexFit.tight,
      child: OutlinedButton(
        onPressed: enable ? onPressed : null,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            enable ? const Color(0xff735E5E) : const Color(0xff3f3f3f),
          ),
        ),
        child: const FeatherIcon(
          FeatherIcons.trash,
          color: Color(0xffb5b5b5),
          size: 40,
        ),
      ),
    );
  }

  Widget favoriteButton({
    Key? key,
    required bool favorited,
    required void Function()? onPressed,
  }) {
    return Flexible(
      key: key,
      fit: FlexFit.tight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(const Color(0xff616161)),
        ),
        child: favorited
            ? const Icon(
                Icons.star,
                color: Color(0xffb5b5b5),
                size: 40,
              )
            : const FeatherIcon(
                FeatherIcons.star,
                color: Color(0xffb5b5b5),
                size: 40,
              ),
      ),
    );
  }

  Widget saveButton({
    Key? key,
    required void Function()? onPressed,
  }) {
    return Flexible(
      key: key,
      fit: FlexFit.tight,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(const Color(0xff616161)),
        ),
        child: _isSaving
            ? const SizedBox.square(
                dimension: 40, child: CircularProgressIndicator())
            : const FeatherIcon(
                FeatherIcons.save,
                color: Color(0xffb5b5b5),
                size: 40,
              ),
      ),
    );
  }
}
