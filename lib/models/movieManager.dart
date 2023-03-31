// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'movie.dart';

class MovieManager extends ChangeNotifier {
  final List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  void addMovieToFavorites(Movie movie) {
    _favorites.add(movie);
    notifyListeners();
  }

  void removeMovieFromFavorites(Movie movie) {
    _favorites.remove(movie);
    notifyListeners();
  }

  bool isMovieFavorite(Movie movie) {
    return _favorites.contains(movie);
  }
  
  void saveMoviesToFavoriteList(List<Movie> movies) {
    _favorites.addAll(movies);
    notifyListeners();
  }

  void clearFavoriteList() {
    _favorites.clear();
    notifyListeners();
  }
}
