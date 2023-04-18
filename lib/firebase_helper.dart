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
    List<Movie> list = [];
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');

    final DatabaseEvent event = (await userFavoritesRef.once());

    var snapshot = event.snapshot;
    final data = snapshot.value;

    for (var child in snapshot.children) {
      Movie movie = Movie.fromJson(child.value as Map<String, dynamic>);
      list.add(movie);
    }
    return list;
    /*
    if (data.containsKey('favorites')) {
      final favoritesData = data['favorites'] as List<dynamic>;
      final favorites =
          favoritesData.map((movieData) => Movie.fromJson(movieData)).toList();
      return favorites;
    } else {
      return [];
    }*/
  }

  /*Future<void> updateFavorites(String userId, List<Movie> favorites) async {
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');
    await userFavoritesRef.set(favorites);
  }*/

  Future<void> updateFavorites(String userId, List<Movie> favorites) async {
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');

    // Set each movie as a child node of the favorites node with the title as the key
    for (final movie in favorites) {
      final title = movie.title.replaceAll('.', '-');
      final movieRef = userFavoritesRef.child(title);
      await movieRef.set(movie.toJson());
    }
  }

  Future<List<Movie>> getData(String uid) async {
    print('Getting data for user $uid...');

    final favorites = <Movie>[];
    final userFavoritesRef =
        firebaseRef.child('users').child(uid).child('favorites');
    final event = await userFavoritesRef.once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      final dynamic data = snapshot.value;
      print('Data retrieved: $data');
      if (data is List<dynamic>) {
        final favoritesData = data;
        print('Favorites data retrieved: $favoritesData');
        final favoritesList = favoritesData
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
        print('Favorites list retrieved: $favoritesList');
        favorites.addAll(favoritesList);
      }
    } else {
      print('No data found.');
    }
    return favorites;
  }
}
