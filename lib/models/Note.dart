import 'package:flutter/material.dart';

class Note {
  String id;
  String title;
  String text;
  bool favorited;
  num lastUpdate;

  @override
  bool operator ==(Object other) {
    if (other is Note) {
      return id == other.id;
    } else {
      return false;
    }
  }

  Note({
    required this.id,
    required this.title,
    required this.text,
    required this.favorited,
    required this.lastUpdate,
  });

  static Note createEmpty() => Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '',
        text: '',
        favorited: false,
        lastUpdate: DateTime.now().millisecondsSinceEpoch,
      );

  Map<String, Map<String, dynamic>> toMap() => {
        id: {
          'title': title,
          'text': text,
          'favorited': favorited,
          'lastUpdate': lastUpdate,
        }
      };

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
