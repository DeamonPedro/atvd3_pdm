import 'package:atvd3_pdm/models/Note.dart';
import 'package:atvd3_pdm/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  NoteProvider._() {
    _loadList();
  }
  static final NoteProvider _noteProvider = NoteProvider._();
  static NoteProvider get instance => _noteProvider;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final AuthService _authService = AuthService.instance;

  DocumentReference get _userDoc =>
      _firestore.collection('users').doc(_authService.userID);

  List<Note> noteList = [];

  Future<void> _loadList() async {
    final userData = await _userDoc.get();
    final notes = (userData.data() as Map)['notes'];
    noteList = [];
    notes.forEach((key, value) {
      noteList.add(
        Note(
          id: key,
          title: value['title'],
          text: value['text'],
          favorited: value['favorited'],
          lastUpdate: value['lastUpdate'],
        ),
      );
    });
    noteList.sort(((a, b) => b.lastUpdate.compareTo(a.lastUpdate)));
    noteList.forEach(((element) => print(element.lastUpdate)));
    notifyListeners();
  }

  Future<void> saveNote(Note note) async {
    await _userDoc.set(
      {
        'notes': note.toMap(),
      },
      SetOptions(merge: true),
    );
    await _loadList();
  }

  Future<void> deleteNote(String noteID) async {
    await _userDoc.update(
      {
        'notes.$noteID': FieldValue.delete(),
      },
    );
    await _loadList();
  }
}
