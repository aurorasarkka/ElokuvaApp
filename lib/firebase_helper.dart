// ignore_for_file: unnecessary_null_comparison, avoid_print, unused_import

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:movie_thing/models/movie.dart';

class FirebaseHelper {
  final DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  Future<void> addUser(String userId) async {
    final userRef = firebaseRef.child('users').child(userId);
    await userRef.set({'favorites': []});
  }

  Future<List<Movie>> getFavorites(String userId) async {
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');
    final DatabaseEvent snapshot = await userFavoritesRef.once();

    print('Firebase data snapshot: ${json.encode(snapshot.snapshot.value)}');

    if (snapshot.snapshot.value != null) {
      final dynamic data = snapshot.snapshot.value;
      final List<Movie> favorites = [];

      if (data is Map<String, dynamic>) {
        data.forEach((key, value) {
          final movie = Movie.fromJson(value as Map<String, dynamic>);
          print('Adding movie: ${movie.title}');
          print(movie); // Add this line to print the movie object
          favorites.add(movie);
        });
      }
      print('Favorites: $favorites');
      return favorites;
    } else {
      print('Favorites is null or empty');
      return [];
    }
  }

  Future<void> updateFavorites(String userId, List<Movie> favorites) async {
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');

    // Set each movie as a child node of the favorites node with the title as the key
    for (final movie in favorites) {
      final title = movie.title.replaceAll('.', '-');
      final movieRef = userFavoritesRef.child(title);
      print('Updating movie: $title, ${movie.toJson()}');
      await movieRef.set(movie.toJson());
    }
    print('Favorites updated successfully');
  }
}
