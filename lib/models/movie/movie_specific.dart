class ResponseSpecificMovie {
  String movieId;
  String resource;
  String releaseYear;
  String title;
  String originalTitle;
  List<String> titles;
  List<String> categories;
  String introduction;
  List<RankScore> rankScores;
  List<Celebrity> actors;
  List<Celebrity> directors;

  ResponseSpecificMovie({
    required this.movieId,
    required this.resource,
    required this.releaseYear,
    required this.title,
    required this.originalTitle,
    required this.titles,
    required this.categories,
    required this.introduction,
    required this.rankScores,
    required this.actors,
    required this.directors,
  });

  factory ResponseSpecificMovie.fromJson(Map<String, dynamic> json) {
    List<String> titles=[];
    if (json['titles']!=null){
      titles=List<String>.from(json['titles']);
    }
    List<String> categories=[];
    if (json['categories']!=null){
      categories=List<String>.from(json['categories']);
    }
    List<Celebrity> directors=[];
    if (json['directors']!=null){
      directors=(json['directors'] as List<dynamic>)
          .map((celebrityJson) => Celebrity.fromJson(celebrityJson))
          .toList();
    }
    List<Celebrity> actors=[];
    if (json["actors"]!=null){
      actors=(json['actors'] as List<dynamic>)
          .map((celebrityJson) => Celebrity.fromJson(celebrityJson))
          .toList();
    }
    List<RankScore> rankScores=[];
    if (json["rank_scores"]!=null){
      rankScores=(json['rank_scores'] as List<dynamic>)
          .map((rankScoreJson) => RankScore.fromJson(rankScoreJson))
          .toList();
    }
    return ResponseSpecificMovie(
      movieId: json['movie_id'],
      resource: json['resource'],
      releaseYear: json['release_year'],
      title: json['title'],
      originalTitle: json['original_title'],
      titles: titles,
      categories: categories,
      introduction: json['introduction'],
      rankScores: rankScores,
      actors: actors,
      directors: directors,
    );
  }
}

class RankScore {
  double score;
  String organization;

  RankScore({
    required this.score,
    required this.organization,
  });

  factory RankScore.fromJson(Map<String, dynamic> json) {
    return RankScore(
      score: json['score'].toDouble(),
      organization: json['organization'],
    );
  }
}

class Celebrity {
  String name;
  String resource;
  String gender;

  Celebrity({
    required this.name,
    required this.resource,
    required this.gender,
  });

  factory Celebrity.fromJson(Map<String, dynamic> json) {
    return Celebrity(
      name: json['name'],
      resource: json['resource'],
      gender: json['gender'],
    );
  }
}
