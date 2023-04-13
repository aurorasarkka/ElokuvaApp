// ignore_for_file: unused_import

import 'package:firebase_database/firebase_database.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/models/movieManager.dart';

class FirebaseHelper {
  final DatabaseReference firebaseRef =
      FirebaseDatabase.instance.ref().child('movies');
}
