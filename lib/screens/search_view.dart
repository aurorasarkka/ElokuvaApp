import 'package:flutter/material.dart';
import 'package:movie_thing/models/genres.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/screens/widgets.dart';

class MovieSearch extends SearchDelegate<Movie?> {
  final ThemeData? themeData;
  final List<Genres>? genres;
  MovieSearch({this.themeData, this.genres});

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = themeData!.copyWith(
        hintColor: themeData!.colorScheme.secondary,
        primaryColor: themeData!.primaryColor,
        textTheme: TextTheme(
          titleLarge: themeData!.textTheme.bodyLarge,
        ));

    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
          color: Color.fromRGBO(99, 227, 227, 300),
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Color.fromRGBO(99, 227, 227, 300),
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchMovieWidget(
      genres: genres,
      themeData: themeData,
      query: query,
      onTap: (movie) {
        close(context, movie);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: themeData!.primaryColor,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              Icons.search,
              size: 50,
              color: Color.fromRGBO(99, 227, 227, 300),
            ),
          ),
          Text('Enter a Movie to search.',
              style: themeData!.textTheme.bodyLarge)
        ],
      )),
    );
  }
}
