import 'package:avec_moi_with_us/models/movie/movie.dart';
import 'package:flutter/material.dart';


class HistoryMovieProvider extends ChangeNotifier {
  late int totalPages;
  late int currentPage;
  late int queryPage;
  late List<Movie> movieList;

  HistoryMovieProvider() {
    totalPages=0;
    currentPage=0;
    queryPage=0;
    movieList=[];
    notifyListeners();
  }

  int getCurrentPage(){
    return currentPage;
  }
  int getTotalPage(){
    return totalPages;
  }
  int getQueryPage(){
    return queryPage;
  }
  List<Movie> getMovieList(){
    return movieList;
  }
  void insertMovie(ResponseMovie data){
    if (data.movieList.isNotEmpty && data.currentPage==queryPage) {
      movieList.addAll(data.movieList);
      totalPages=data.totalPages;
      currentPage=data.currentPage;
      notifyListeners();
    }
  }
  void emptyMovie(){
    totalPages=0;
    currentPage=0;
    queryPage=1;
    movieList=[];
    notifyListeners();
  }
}
