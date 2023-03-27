// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_thing/api/endpoints.dart';
import 'package:movie_thing/models/genres.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/models/functions.dart';
import 'package:movie_thing/screens/movie_detail.dart';
import 'package:movie_thing/screens/search_view.dart';
import 'package:movie_thing/screens/welcome.dart';
import 'package:movie_thing/screens/widgets.dart';
import 'package:movie_thing/theme/theme_state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeState>(
      create: (_) => ThemeState(),
      child: MaterialApp(
        title: 'Movie List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.green, canvasColor: Colors.transparent),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Genres> _genres = [];
  @override
  void initState() {
    super.initState();
    fetchGenres().then((value) {
      _genres = value.genres ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: state.themeData.colorScheme.secondary,
          ),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        centerTitle: true,
        title: Text(
          'Movie List',
          style: state.themeData.textTheme.headlineSmall,
        ),
        backgroundColor: state.themeData.primaryColor,
        actions: <Widget>[
          IconButton(
            color: state.themeData.colorScheme.secondary,
            icon: const Icon(Icons.search),
            onPressed: () async {
              final Movie? result = await showSearch<Movie?>(
                  context: context,
                  delegate:
                      MovieSearch(themeData: state.themeData, genres: _genres));
              if (result != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailPage(
                            movie: result,
                            themeData: state.themeData,
                            genres: _genres,
                            heroId: '${result.id}search')));
              }
            },
          )
        ],
      ),
      drawer: Drawer(
        child: WelcomePage(),
      ),
      body: Container(
        color: state.themeData.primaryColor,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            DiscoverMovies(
              themeData: state.themeData,
              genres: _genres,
            ),
            ScrollingMovies(
              themeData: state.themeData,
              title: 'Top Rated',
              api: Endpoints.topRatedUrl(1),
              genres: _genres,
            ),
            ScrollingMovies(
              themeData: state.themeData,
              title: 'Now Playing',
              api: Endpoints.nowPlayingMoviesUrl(1),
              genres: _genres,
            ),
            // ScrollingMovies(
            //   themeData: state.themeData,
            //   title: 'Upcoming Movies',
            //   api: Endpoints.upcomingMoviesUrl(1),
            //   genres: _genres,
            // ),
            ScrollingMovies(
              themeData: state.themeData,
              title: 'Popular',
              api: Endpoints.popularMoviesUrl(1),
              genres: _genres,
            ),
          ],
        ),
      ),
    );
  }
}
