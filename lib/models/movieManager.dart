// ignore_for_file: avoid_print, file_names, unused_import, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_thing/firebase_helper.dart';
import '../main.dart';
import 'movie.dart';

class MovieManager extends ChangeNotifier {
  List<Movie> _favorites;

  MovieManager(List<Movie> favorites) : _favorites = favorites {
    loadFromFirebase().then((movies) {
      _favorites.addAll(movies);
      notifyListeners();
    });
  }

  // Returns the list of favorite movies
  List<Movie> get favorites => _favorites;

  final FirebaseHelper _firebaseHelper = FirebaseHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Adds a movie to the list of favorite movies and notifies any listeners that the state has changed
  void addMovie(Movie movie) async {
    if (!_favorites.contains(movie)) {
      _favorites.add(movie);
      print('Movie added: $movie');
      await _firebaseHelper.updateFavorites(_auth.currentUser!.uid, _favorites);
      notifyListeners();
    }
  }

  // Removes a movie from the list of favorite movies and notifies any listeners that the state has changed
  void removeMovie(Movie movie) async {
    _favorites.remove(movie);
    print('Removed from favorites: ${movie.title}');
    await _firebaseHelper.updateFavorites(_auth.currentUser!.uid, _favorites);
    _favorites = await loadFromFirebase();
    notifyListeners();
  }

  // Checks if a movie is a favorite by checking if it is in the _favorites list and returns a boolean value
  bool isMovieFavorite(Movie movie) {
    for (Movie current in favorites) {
      if (movie.title == current.title) {
        return true;
      }
    }
    return false;
  }

  // Adds a list of movies to the list of favorite movies and notifies any listeners that the state has changed
  void saveMoviesToFavoriteList(List<Movie> movies) {
    _favorites.addAll(movies);
    notifyListeners();
  }

  // Clears the list of favorite movies and notifies any listeners that the state has changed
  void clearFavoriteList() {
    _favorites.clear();
    notifyListeners();
  }

  void toggleFavorite(Movie movie, BuildContext context) {
    Movie? found;
    for (Movie current in favorites) {
      if (movie.title == current.title) {
        found = current;
        break;
      }
    }
    if (found != null) {
      removeMovie(found);
      print('Removed from favorites: ${movie.title}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed from favorites: ${movie.title}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } else {
      addMovie(movie);
    }
  }

  Future<List<Movie>> loadFromFirebase() async {
    try {
      print('Loading movies from Firebase...');
      final user = _auth.currentUser;
      if (user == null) {
        print('User not authenticated');
        return [];
      }
      final list = await _firebaseHelper.getFavorites(user.uid);
      print('Loaded ${list.length} movies from Firebase');
      print(list);
      return list;
    } catch (e) {
      print('Error loading movies from Firebase: $e');
      return [];
    }
  }
}
