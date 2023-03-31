// ignore_for_file: prefer_interpolation_to_compose_strings, library_private_types_in_public_api, prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:movie_thing/api/endpoints.dart';
import 'package:movie_thing/constats/api_constats.dart';
import 'package:movie_thing/models/credits.dart';
import 'package:movie_thing/models/genres.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/screens/widgets.dart';

//SIVU MISSÄ NÄKEE LEFFAN TIEDOT KUN KUVAKETTA KLIKATTU

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  final ThemeData themeData;
  final String heroId;
  final List<Genres> genres;

  const MovieDetailPage(
      {super.key,
      required this.movie,
      required this.themeData,
      required this.heroId,
      required this.genres});
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isFavorite = false;
  List<Movie> favoriteMovies = [];

 void toggleFavorite() {
  setState(() {
    if (favoriteMovies.contains(widget.movie)) {
      favoriteMovies.remove(widget.movie);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed from favorites: ${widget.movie.title}'),
          duration: Duration(seconds: 5),
        ),
      );
      print('Removed from favorites: ${widget.movie.title}');
    } else {
      favoriteMovies.add(widget.movie);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added to favorites: ${widget.movie.title}'),
          duration: Duration(seconds: 5),
        ),
      );
      print('Added to favorites: ${widget.movie.title}');
    }
  });
}

  @override
  Widget build(BuildContext context) {
    Color favoriteColor = isFavorite ? Colors.red : Colors.white;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    widget.movie.backdropPath == null
                        ? Image.asset(
                            'lib/assets/images/black.jpg',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            width: double.infinity,
                            height: double.infinity,
                            image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                'original/' +
                                widget.movie.backdropPath!),
                            fit: BoxFit.cover,
                            placeholder:
                                AssetImage('lib/assets/images/loading.gif'),
                          ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                widget.themeData.colorScheme.secondary,
                                widget.themeData.colorScheme.secondary
                                    .withOpacity(0.3),
                                widget.themeData.colorScheme.secondary
                                    .withOpacity(0.2),
                                widget.themeData.colorScheme.secondary
                                    .withOpacity(0.1),
                              ],
                              stops: const [
                                0.0,
                                0.25,
                                0.5,
                                0.75
                              ])),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: widget.themeData.colorScheme.secondary,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: widget.themeData.colorScheme.secondary,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: widget.themeData.primaryColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.movie.title!,
                                          style: widget.themeData.textTheme
                                              .headlineSmall,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                widget.movie.voteAverage!,
                                                style: widget.themeData
                                                    .textTheme.bodyLarge,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.yellow,
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  isFavorite //sydän ikoni
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  color: favoriteColor,
                                                ),
                                                onPressed: () {
                                                  toggleFavorite();
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        widget.genres.isEmpty
                                            ? Container()
                                            : GenreList(
                                                themeData: widget.themeData,
                                                genres:
                                                    widget.movie.genreIds ?? [],
                                                totalGenres: widget.genres,
                                              ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Overview',
                                                style: widget.themeData
                                                    .textTheme.bodyLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            widget.movie.overview!,
                                            style: widget
                                                .themeData.textTheme.bodySmall,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text(
                                                'Release date : ${widget.movie.releaseDate}',
                                                style: widget.themeData
                                                    .textTheme.bodyLarge,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ScrollingArtists(
                                          api: Endpoints.getCreditsUrl(
                                              widget.movie.id!),
                                          title: 'Cast',
                                          tapButtonText: 'See full cast & crew',
                                          themeData: widget.themeData,
                                          onTap: (Cast cast) {
                                            modalBottomSheetMenu(cast);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 40,
                        child: Hero(
                          tag: widget.heroId,
                          child: SizedBox(
                            width: 100,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: widget.movie.posterPath == null
                                  ? Image.asset(
                                      'lib/assets/images/black.jpg',
                                      fit: BoxFit.cover,
                                    )
                                  : FadeInImage(
                                      image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                          'w500/' +
                                          widget.movie.posterPath!),
                                      fit: BoxFit.cover,
                                      placeholder: AssetImage(
                                          'lib/assets/images/loading.gif'),
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void modalBottomSheetMenu(Cast cast) {
    // double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            // height: height / 2,
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                      padding: const EdgeInsets.only(top: 54),
                      decoration: BoxDecoration(
                          color: widget.themeData.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0))),
                      child: Center(
                        child: ListView(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${cast.name}',
                                    style:
                                        widget.themeData.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    'as',
                                    style:
                                        widget.themeData.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${cast.character}',
                                    style:
                                        widget.themeData.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            color: widget.themeData.primaryColor,
                            border: Border.all(
                                color: widget.themeData.colorScheme.secondary,
                                width: 3),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: (cast.profilePath == null
                                        ? const AssetImage(
                                            'lib/assets/images/black.jpg')
                                        : NetworkImage(TMDB_BASE_IMAGE_URL +
                                            'w500/' +
                                            cast.profilePath!))
                                    as ImageProvider<Object>),
                            shape: BoxShape.circle),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}