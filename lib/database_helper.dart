// ignore_for_file: unused_import, avoid_print, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/models/movieManager.dart';

class DatabaseHelper {
  static late Database _db;
  static MovieManager favorites = MovieManager(<Movie>[]);
  static const _databaseName = "MovieDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'movie';
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

  DatabaseHelper() {
    init();
  }

  Future<void> init() async {
    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, _databaseName);
      _db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
      print('Database initialized at $path');
    } catch (e) {
      print('Error initializing database: $e');
    }
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    print('Creating database table...');
    await db.execute('''
          CREATE TABLE $table (
        $columnVoteCount num,
        $columnId num, 
        $columnVideo num,
        $columnVoteAverage num,
        $columnTitle String,
        $columnPopularity num,
        $columnPosterPath String,
        $columnOriginalLanguage String, 
        $columnOriginalTitle String,
        $columnGenreIds String,
        $columnBackdropPath String,
        $columnAdult num, 
        $columnOverview String,
        $columnFbid String,
        $columnReleaseDate String
      )
          ''');
  }

  Future<int> insertFavoriteMovie(Movie movie) async {
    // Add the new movie to the favorites list.
    DatabaseHelper.favorites.addMovie(movie);

    // Initialize the database if it has not been initialized yet
    if (_db == null) {
      await init();
    }

    // Wait for the init method to complete before proceeding
    await init();

    // Insert the movie into the database.
    final Map<String, dynamic> row = movie.toJson();
    return await _db.insert(table, row);
  }

  Future<List<Movie>> queryAllRows() async {
    // Ensure that _db has been initialized before accessing it
    if (_db == null) {
      await init();
    }

    // Query all rows from the table and map the results to Movie objects
    final List<Map<String, dynamic>> rows = await _db.query(table);
    final List<Movie> movies = rows.map((row) => Movie.fromJson(row)).toList();

    return movies;
  }

  Future<int> update(Map<String, dynamic> row) async {
    print("Movie updated in database: ${row[columnTitle]}");

    int id = row[columnTitle];
    return await _db.update(
      table,
      row,
      where: '$columnId= ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    print("Movie deleted from database: $id");

    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateMovies(List<Movie> movie) async {
    await _db.transaction((txn) async {
      // Clear existing movies
      await txn.delete(table);

      // Insert new movies
      for (var movie in movie) {
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
