import 'package:avec_moi_with_us/models/movie/movie.dart';
import 'package:flutter/material.dart';


class HotMovieProvider extends ChangeNotifier {
  late int totalPages;
  late int currentPage;
  late List<Movie> movieList;

  HotMovieProvider() {
    totalPages=0;
    currentPage=0;
    movieList=[];
    notifyListeners();
  }

  int getCurrentPage(){
    return currentPage;
  }
  int getTotalPage(){
    return totalPages;
  }
  List<Movie> getMovieList(){
    return movieList;
  }
  void insertMovie(ResponseMovie data){
    if (data.movieList.isNotEmpty) {
      movieList.addAll(data.movieList);
      totalPages=data.totalPages;
      currentPage=data.currentPage;
      notifyListeners();
    }
  }
  void emptyMovie(){
    totalPages=0;
    currentPage=0;
    movieList=[];
    notifyListeners();
  }
}
