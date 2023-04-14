// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unused_field, avoid_print, unused_import

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_thing/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:movie_thing/api/endpoints.dart';
import 'package:movie_thing/models/genres.dart';
import 'package:movie_thing/models/movie.dart';
import 'package:movie_thing/models/functions.dart';
import 'package:movie_thing/screens/movie_detail.dart';
import 'package:movie_thing/screens/search_view.dart';
import 'package:movie_thing/screens/widgets.dart';
import 'package:movie_thing/theme/theme_state.dart';
import 'package:movie_thing/screens/favorites.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'database_helper.dart';
import 'models/movieManager.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<Movie> favorites = [];
final auth = FirebaseAuth.instance;
final dbHelper = DatabaseHelper();

Future<void> main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      await Firebase.initializeApp(),
      await dbHelper.init(),
      runApp(const MyApp()),
    };

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Movie> favorites = [];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider(create: (_) => MovieManager(favorites)),
      ],
      child: MaterialApp(
        title: 'Movie List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromRGBO(255, 255, 255, 100),
          canvasColor: Colors.transparent,
        ),
        home: MyHomePage(favorites: favorites),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Movie> favorites;

  const MyHomePage({Key? key, required this.favorites}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Genres> _genres = [];

  late final http.Client httpClient;

  Movie? _randomMovie;

  @override
  void initState() {
    super.initState();
    httpClient = http.Client();
    fetchGenres().then((value) {
      _genres = value.genres ?? [];
    });
  }

  Future<Movie> fetchRandomMovie() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=af7dcb5d262bb63669ebdb759100da85'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final List<dynamic> results = responseBody['results'];
      final random = Random();
      final randomIndex = random.nextInt(results.length);
      final Map<String, dynamic> randomResult = results[randomIndex];
      print('Fetched random movie: ${randomResult['title']}');
      return Movie.fromJson(randomResult);
    } else {
      print('Failed to fetch random movie: ${response.statusCode}');
      throw Exception('Failed to fetch random movie');
    }
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
          //RANDOM ELOKUVA -PAINIKE
          IconButton(
            color: state.themeData.colorScheme.secondary,
            icon: const Icon(Icons.shuffle),
            onPressed: () async {
              try {
                final randomMovie = await fetchRandomMovie();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailPage(
                      movie: randomMovie,
                      themeData: state.themeData,
                      genres: _genres,
                      heroId: '${randomMovie.id}random',
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to fetch random movie')),
                );
              }
            },
          ),

          //SUOSIKIT -PAINIKE
          IconButton(
            color: state.themeData.colorScheme.secondary,
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              print('Favorites button tapped');
              final user = auth.currentUser;
              print('Current user: $user');

              // Retrieve the list of favorite movies from the MovieManager
              if (user != null) {
                final List<Movie> favorites =
                    Provider.of<MovieManager>(context, listen: false).favorites;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(
                      favorites: favorites,
                      genres: const {},
                    ),
                  ),
                );
              } else {
                print('test print 1000');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('You must be logged in to access this feature'),
                  ),
                );
                print('User not logged in, access denied');
              }
            },
          ),

          //HAKU -PAINIKE
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
          ),
        ],
      ),
      drawer: const Drawer(
        child: LoginPage(),
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
