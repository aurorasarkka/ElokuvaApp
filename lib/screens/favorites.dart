// ignore_for_file: file_names, unused_local_variable

import 'package:flutter/material.dart';
import '../models/movie.dart';

class Favorites extends StatelessWidget {
  final List<Movie> favorites;

  const Favorites({Key? key, List<Movie>? favorites})
      : favorites = favorites ?? const [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          String title = favorites[index].title ?? "No Title";
          return ListTile(
            title: Text(title),
          );
        },
      ),
    );
  }
}
