// ignore_for_file: avoid_print, unused_import

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_thing/models/movie.dart';

class FirebaseHelper {
  final DatabaseReference firebaseRef = FirebaseDatabase.instance.ref();

  Future<void> addUser(String userId) async {
    final userRef = firebaseRef.child('users').child(userId);
    await userRef.set({'favorites': []});
  }

  List<Movie> parseMovies(String jsonData) {
    print("Parsing movies data: $jsonData");
    try {
      final decoded = json.decode(jsonData);
      print("Decoded JSON type: ${decoded.runtimeType}");
      if (decoded is List) {
        return decoded.map<Movie>((json) => Movie.fromJson(json)).toList();
      } else {
        return [Movie.fromJson(decoded)];
      }
    } catch (e) {
      print("Error parsing JSON: $e");
      return [];
    }
  }

  Future<List<Movie>> getFavorites(String userId) async {
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');

    final DatabaseEvent snapshot = await userFavoritesRef.once();

    print('Firebase data snapshot: ${json.encode(snapshot.snapshot.value)}');

    final List<Movie> favorites = [];

    if (snapshot.snapshot.value != null && snapshot.snapshot.value is Map) {
      final dynamic data = snapshot.snapshot.value;

      data.forEach((key, value) {
        favorites.addAll(parseMovies(json.encode(value)));
      });
    }

    return favorites; // Return the list of movies
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
