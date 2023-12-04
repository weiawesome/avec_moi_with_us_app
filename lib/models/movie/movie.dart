class ResponseMovie {
  int totalPages;
  int currentPage;
  List<Movie> movieList;

  ResponseMovie({
    required this.totalPages,
    required this.currentPage,
    required this.movieList,
  });

  factory ResponseMovie.fromJson(Map<String, dynamic> json) {
    List<Movie> movies=[];
    if (json["movies"]!=null){
      movies=(json['movies'] as List<dynamic>)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    }
    return ResponseMovie(
      totalPages: json['total_pages'],
      currentPage: json['current_page'],
      movieList: movies,
    );
  }
}

class Movie {
  String movieId;
  String resource;
  String releaseYear;
  String title;
  double score;

  Movie({
    required this.movieId,
    required this.resource,
    required this.releaseYear,
    required this.title,
    required this.score,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieId: json['movie_id'],
      resource: json['resource'],
      releaseYear: json['release_year'],
      title: json['title'],
      score: json['score'].toDouble(),
    );
  }
}
