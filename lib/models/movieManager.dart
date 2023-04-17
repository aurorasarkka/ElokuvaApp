// ignore_for_file: avoid_print, file_names, unused_import, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_thing/database_helper.dart';
import 'package:movie_thing/firebase_helper.dart';
import '../main.dart';
import 'movie.dart';

class MovieManager extends ChangeNotifier {
  List<Movie> _favorites;

  MovieManager(List<Movie> favorites) : _favorites = favorites {
    loadFromdb().then((movies) {
      _favorites.addAll(movies);
      notifyListeners();
    });
  }
  // Returns the list of favorite movies
  List<Movie> get favorites => _favorites;

  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get movies => null;

  Future<List<Map<String, dynamic>>> queryAllRows(DatabaseHelper db) async {
    return await db.query(DatabaseHelper.table);
  }

  Future<List<Movie>> loadFromdb() async {
    print('Loading movies from database...');
    final list = await queryAllRows(_databaseHelper);
    return list.map((map) => Movie.fromJson(map)).toList();
  }

  // Adds a movie to the list of favorite movies and notifies any listeners that the state has changed
  void addMovie(Movie movie) async {
    if (!_favorites.contains(movie)) {
      _favorites.add(movie);
      await _databaseHelper
          .updateMovies(_favorites); // Update movies in database
      _favorites = await loadFromdb();
      print('Movie added: $movie');
      print('Favorites list: $_favorites');
      notifyListeners();
    }
  }

  // Removes a movie from the list of favorite movies and notifies any listeners that the state has changed
  void removeMovie(Movie movie) async {
    _favorites.remove(movie);
    await _databaseHelper.updateMovies(_favorites); // Update movies in database
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
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  List<Movie> getFavoriteMovies() {
    return favorites;
  }

  /*loadFromFirebase() async {
    final firebaseHelper = FirebaseHelper();
    final list = await firebaseHelper.getData();
    for (Movie item in list) {
      _favorites.add(item);
    }
    notifyListeners();
  }*/
}
