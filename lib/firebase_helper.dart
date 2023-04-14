// ignore_for_file: unnecessary_null_comparison

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
    final DataSnapshot snapshot =
        (await userFavoritesRef.once()) as DataSnapshot;
    final data = snapshot.value as Map<dynamic, dynamic>;
    if (data.containsKey('favorites')) {
      final favoritesData = data['favorites'] as List<dynamic>;
      final favorites =
          favoritesData.map((movieData) => Movie.fromJson(movieData)).toList();
      return favorites;
    } else {
      return [];
    }
  }

  Future<void> updateFavorites(String userId, List<Movie> favorites) async {
    final userFavoritesRef =
        firebaseRef.child('users').child(userId).child('favorites');
    await userFavoritesRef.set(favorites);
  }

  Future<List<Movie>> getData() async {
    List<Movie> favorites = [];

    DatabaseEvent event = await firebaseRef
        .orderByChild("userid")
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .once();
    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      Movie movie = Movie.fromJson(child.value as Map<String, dynamic>);
      movie.fbid = child.key;
      favorites.add(movie);
    }
    return favorites;
  }
}
