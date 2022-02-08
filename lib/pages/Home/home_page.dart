import 'package:atvd3_pdm/models/Note.dart';
import 'package:atvd3_pdm/provider/note_provider.dart';
import 'package:atvd3_pdm/utils/date_tools.dart';
import 'package:feather_icons_svg/feather_icons_svg.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final NoteProvider noteProvider = NoteProvider.instance;

  @override
  void initState() {
    super.initState();
    noteProvider.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    noteProvider.removeListener(() => setState(() {}));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Notes',
                      style: TextStyle(
                        color: Color(0xff745F5F),
                        fontSize: 30,
                      ),
                    ),
                    FeatherIcon(
                      FeatherIcons.bookmark,
                      size: 30,
                      color: Color(0xff745F5F),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: noteProvider.noteList.length,
                    itemBuilder: (context, index) {
                      final note = noteProvider.noteList[index];
                      return noteItem(note);
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: floatingButton(context),
    );
  }

  Padding floatingButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonSize = MaterialStateProperty.all<Size>(
        Size(0.18 * screenWidth, 0.18 * screenWidth));

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, right: 20),
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, '/note',
            arguments: Note.createEmpty()),
        style: ButtonStyle(
          minimumSize: buttonSize,
          maximumSize: buttonSize,
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(const Color(0xff735E5E)),
        ),
        child: FeatherIcon(
          FeatherIcons.edit,
          color: const Color(0xffb5b5b5),
          size: 10 * screenWidth,
        ),
      ),
    );
  }

  Padding noteItem(Note note) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          minimumSize:
              MaterialStateProperty.all<Size>(const Size(double.infinity, 150)),
          maximumSize:
              MaterialStateProperty.all<Size>(const Size(double.infinity, 150)),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(const Color(0xff616161)),
        ),
        onPressed: () => Navigator.pushNamed(context, '/note', arguments: note),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const FeatherIcon(
                      FeatherIcons.edit3,
                      color: Color(0xffebebeb),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        note.title,
                        style: const TextStyle(
                          color: Color(0xffebebeb),
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ]),
                  Visibility(
                    visible: note.favorited,
                    child: const FeatherIcon(
                      FeatherIcons.star,
                      color: Color(0xffBC9713),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  note.text,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(
                      0xffb5b5b5,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    formatDate(note.lastUpdate),
                    style: const TextStyle(
                      color: Color(0xffebebeb),
                      fontSize: 12,
                    ),
                  ),
                ),
                const FeatherIcon(
                  FeatherIcons.calendar,
                  color: Color(0xffb5b5b5),
                  size: 22,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
