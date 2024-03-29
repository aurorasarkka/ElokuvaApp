class MovieList {
  int? page;
  int? totalMovies;
  int? totalPages;
  List<Movie>? movies;

  MovieList({this.page, this.totalMovies, this.totalPages, this.movies});

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalMovies = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      movies = [];
      json['results'].forEach((v) {
        movies!.add(Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['total_results'] = totalMovies;
    data['total_pages'] = totalPages;
    if (movies != null) {
      data['results'] = movies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  int? voteCount;
  int? id;
  int? video; // use 0 for false, 1 for true
  String? voteAverage;
  late String title;
  double? popularity;
  String? posterPath;
  String? originalLanguage;
  String? originalTitle;
  List<int>? genreIds;
  String? backdropPath;
  int? adult; // use 0 for false, 1 for true
  String? overview;
  String? fbid;
  late String releaseDate;

  Movie(
      {this.voteCount,
      this.id,
      this.video,
      this.voteAverage,
      required this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.backdropPath,
      this.adult,
      this.overview,
      this.fbid,
      required this.releaseDate,
      required year,
      required rated,
      required released,
      required runtime,
      required List<String> genres,
      required website,
      required production,
      required boxOffice});

  Movie.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'] == true ? 1 : 0;
    voteAverage = json['vote_average'].toString();
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'] == true ? 1 : 0;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vote_count'] = voteCount;
    data['id'] = id;
    data['video'] = video == 1;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['genre_ids'] = genreIds;
    data['backdrop_path'] = backdropPath;
    data['adult'] = adult == 1;
    data['overview'] = overview;
    data['release_date'] = releaseDate;
    return data;
  }
}
