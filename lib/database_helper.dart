import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/models/movieManager.dart';

class DatabaseHelper {
  static MovieManager favorites = MovieManager(<Movie>[]);
  static const _databaseName = "MovieDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'movies';
  static const columnVoteCount = 'vote_count';
  static const columnId = 'id';
  static const columnVideo = 'video';
  static const columnVoteAverage = 'vote_average';
  static const columnTitle = 'title';
  static const columnPopularity = 'popularity';
  static const columnPosterPath = 'poster_path';
  static const columnOriginalLanguage = 'original_language';
  static const columnOriginalTitle = 'original_title';
  static const columnGenreIds = 'genre_ids';
  static const columnBackdropPath = 'backdrop_path';
  static const columnAdult = 'adult';
  static const columnOverview = 'overview';
  static const columnFbid = 'Fbid';
  static const columnReleaseDate = 'release_date';

  late Database _db;

  DatabaseHelper() {
    init();
  }
  //static const columnFbid = 'fbid';

  // this opens the database (and creates it if it doesn't exist)
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
        $columnVoteCount INTEGER,
        $columnId INTEGER, 
        $columnVideo BOOL,
        $columnVoteAverage REAL,
        $columnTitle TEXT,
        $columnPopularity REAL,
        $columnPosterPath TEXT,
        $columnOriginalLanguage TEXT, 
        $columnOriginalTitle TEXT,
        $columnGenreIds TEXT,
        $columnBackdropPath TEXT,
        $columnAdult BOOL, 
        $columnOverview TEXT,
        $columnFbid TEXT,
        $columnReleaseDate TEXT,
        
      )
          ''');
    //$columnFbid TEXT
  }

  Future<int> insertFavoriteMovie(Movie movie) async {
    // Add the new movie to the favorites list
    DatabaseHelper.favorites.addMovie(movie);

    // Ensure that _db has been initialized before accessing it
    if (_db == null) {
      await init();
    }

    final Map<String, dynamic> row = movie.toJson();
    return await _db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    // Get the list of movies from the favorites list
    final movies = DatabaseHelper.favorites.movies;

    // Create a list of rows from the movies list
    final List<Map<String, dynamic>> rows = [];
    for (final movie in movies) {
      rows.add(movie.toJson());
    }

    return rows;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnTitle];
    return await _db.update(
      table,
      row,
      where: '$columnTitle = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnTitle = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateMovies(List<Movie> movies) async {
    await _db.transaction((txn) async {
      // Clear existing movies
      await txn.delete(table);

      // Insert new movies
      for (var movie in movies) {
        await txn.insert(table, movie.toJson());
      }
    });
  }

  Future<List<Map<String, dynamic>>> query(String table,
      {List<String>? columns, String? where, List<dynamic>? whereArgs}) async {
    return await _db.query(table,
        columns: columns, where: where, whereArgs: whereArgs);
  }
}
